#!/bin/bash
# InstallBuilder XML Validation Script
# Validates all XML files for well-formedness and checks variable references

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "============================================"
echo "  InstallBuilder XML Validation"
echo "============================================"
echo ""

ERRORS=0
WARNINGS=0

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to validate XML well-formedness
validate_xml() {
    local file="$1"
    if xmllint --noout "$file" 2>/dev/null; then
        echo -e "${GREEN}[PASS]${NC} $file"
        return 0
    else
        echo -e "${RED}[FAIL]${NC} $file"
        xmllint --noout "$file" 2>&1 | sed 's/^/       /'
        return 1
    fi
}

# Function to validate XML against XSD schema
validate_xsd() {
    local file="$1"
    local schema="$2"
    if xmllint --noout --schema "$schema" "$file" 2>/dev/null; then
        echo -e "${GREEN}[PASS]${NC} $file (schema valid)"
        return 0
    else
        echo -e "${RED}[FAIL]${NC} $file (schema validation)"
        xmllint --noout --schema "$schema" "$file" 2>&1 | sed 's/^/       /'
        return 1
    fi
}

# 1. Validate XML well-formedness
echo "1. Checking XML Well-formedness"
echo "--------------------------------"

# Check if xmllint is available
if ! command -v xmllint &> /dev/null; then
    echo -e "${YELLOW}[WARN]${NC} xmllint not found. Install with: sudo apt install libxml2-utils"
    echo "       Skipping XML validation..."
    WARNINGS=$((WARNINGS + 1))
else
    # Validate main template
    if [ -f "installer-template.xml" ]; then
        validate_xml "installer-template.xml" || ERRORS=$((ERRORS + 1))
    fi

    # Validate variables template
    if [ -f "variables-template.xml" ]; then
        validate_xml "variables-template.xml" || ERRORS=$((ERRORS + 1))
    fi

    # Validate all product files
    for product_dir in products/*/; do
        if [ -d "$product_dir" ]; then
            product_name=$(basename "$product_dir")

            for xml_file in "$product_dir"*.xml; do
                if [ -f "$xml_file" ]; then
                    validate_xml "$xml_file" || ERRORS=$((ERRORS + 1))
                fi
            done
        fi
    done

    # XSD Schema Validation for variables.xml
    echo ""
    echo "1b. Validating Against XSD Schema"
    echo "----------------------------------"

    SCHEMA_FILE="schemas/variables.xsd"
    if [ -f "$SCHEMA_FILE" ]; then
        # Validate variables template
        if [ -f "variables-template.xml" ]; then
            validate_xsd "variables-template.xml" "$SCHEMA_FILE" || ERRORS=$((ERRORS + 1))
        fi

        # Validate product variables
        for product_dir in products/*/; do
            if [ -d "$product_dir" ]; then
                variables_file="$product_dir/variables.xml"
                if [ -f "$variables_file" ]; then
                    validate_xsd "$variables_file" "$SCHEMA_FILE" || ERRORS=$((ERRORS + 1))
                fi
            fi
        done
    else
        echo -e "${YELLOW}[WARN]${NC} Schema file not found: $SCHEMA_FILE"
        WARNINGS=$((WARNINGS + 1))
    fi
fi

echo ""

# 2. Check required variables are defined
echo "2. Checking Required Variables"
echo "-------------------------------"

REQUIRED_VARS=(
    "PRODUCT_SHORT_NAME"
    "PRODUCT_NAME"
    "PRODUCT_VERSION"
    "VENDOR_NAME"
    "WINDOWS_EXECUTABLE"
    "LINUX_EXECUTABLE"
    "SOURCE_DIR"
    "COMPONENTS_FILE"
    "SHORTCUTS_FILE"
    "LICENSE_FILE"
    "DEFAULT_INSTALL_DIR"
)

for product_dir in products/*/; do
    if [ -d "$product_dir" ]; then
        product_name=$(basename "$product_dir")
        variables_file="$product_dir/variables.xml"

        if [ -f "$variables_file" ]; then
            echo "Checking $product_name..."
            missing=0

            for var in "${REQUIRED_VARS[@]}"; do
                if ! grep -q "<$var>" "$variables_file"; then
                    echo -e "  ${RED}[MISSING]${NC} $var"
                    missing=$((missing + 1))
                fi
            done

            if [ $missing -eq 0 ]; then
                echo -e "  ${GREEN}[OK]${NC} All required variables defined"
            else
                ERRORS=$((ERRORS + missing))
            fi
        else
            echo -e "${YELLOW}[WARN]${NC} $product_name: No variables.xml found"
            WARNINGS=$((WARNINGS + 1))
        fi
    fi
done

echo ""

# 3. Check file inclusions
echo "3. Checking File Inclusions"
echo "----------------------------"

for product_dir in products/*/; do
    if [ -d "$product_dir" ]; then
        product_name=$(basename "$product_dir")

        # Check components.xml exists
        if [ ! -f "$product_dir/components.xml" ]; then
            echo -e "${RED}[MISSING]${NC} $product_name/components.xml"
            ERRORS=$((ERRORS + 1))
        else
            echo -e "${GREEN}[OK]${NC} $product_name/components.xml"
        fi

        # Check shortcuts.xml exists
        if [ ! -f "$product_dir/shortcuts.xml" ]; then
            echo -e "${RED}[MISSING]${NC} $product_name/shortcuts.xml"
            ERRORS=$((ERRORS + 1))
        else
            echo -e "${GREEN}[OK]${NC} $product_name/shortcuts.xml"
        fi

        # Check shortcuts inclusion in components
        if [ -f "$product_dir/components.xml" ]; then
            if ! grep -q '<include>\${SHORTCUTS_FILE}</include>' "$product_dir/components.xml"; then
                echo -e "${YELLOW}[WARN]${NC} $product_name: shortcuts.xml not included in components.xml"
                WARNINGS=$((WARNINGS + 1))
            fi
        fi
    fi
done

echo ""

# 4. Check component-shortcut alignment
echo "4. Checking Component-Shortcut Alignment"
echo "-----------------------------------------"

for product_dir in products/*/; do
    if [ -d "$product_dir" ]; then
        product_name=$(basename "$product_dir")
        components_file="$product_dir/components.xml"
        shortcuts_file="$product_dir/shortcuts.xml"

        if [ -f "$components_file" ] && [ -f "$shortcuts_file" ]; then
            # Get component names from shortcuts (componentTest references)
            shortcut_refs=$(grep -o '<name>[^<]*</name>' "$shortcuts_file" | grep -oP '(?<=<name>)[^<]+' | grep -v '\$' | sort -u 2>/dev/null || true)

            # Check if referenced components exist
            for ref in $shortcut_refs; do
                if echo "$ref" | grep -qE '^(solver|python|documentation|visual|intelmpi)$'; then
                    if ! grep -q "<name>$ref</name>" "$components_file"; then
                        echo -e "${YELLOW}[WARN]${NC} $product_name: Component '$ref' referenced in shortcuts but not in components"
                        WARNINGS=$((WARNINGS + 1))
                    fi
                fi
            done
        fi

        echo -e "${GREEN}[OK]${NC} $product_name alignment checked"
    fi
done

echo ""

# Summary
echo "============================================"
echo "  Validation Summary"
echo "============================================"

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}All checks passed!${NC}"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}Warnings: $WARNINGS${NC}"
    echo -e "${GREEN}Errors: 0${NC}"
    exit 0
else
    echo -e "${YELLOW}Warnings: $WARNINGS${NC}"
    echo -e "${RED}Errors: $ERRORS${NC}"
    exit 1
fi
