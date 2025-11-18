# InstallBuilder Multi-Product Installer Framework

A modular XML-based framework for building cross-platform installers using InstallBuilder. Supports **Windows** and **Linux (x64)** platforms with externalized configuration for easy multi-product management.

---

## Table of Contents

- [Architecture](#architecture)
- [How It Works](#how-it-works)
- [Build Command](#build-command)
- [Variables Reference](#variables-reference)
- [Supported Platforms](#supported-platforms)
- [Adding a New Product](#adding-a-new-product)
- [Validation](#validation)
- [Current Products](#current-products)

---

## Architecture

```
InstallBuilder/
├── installer-template.xml      # Main installer template
├── variables-template.xml      # Template for new products
├── validate.sh                 # Validation script
├── schemas/
│   └── variables.xsd           # XSD schema for validation
└── products/
    ├── product-A/
    │   ├── variables.xml       # Product-specific variables
    │   ├── components.xml      # Component definitions
    │   └── shortcuts.xml       # Shortcut definitions
    └── product-B/
        ├── variables.xml
        ├── components.xml
        └── shortcuts.xml
```

---

## How It Works

```
┌─────────────────────┐
│  variables.xml      │  (Product-specific values)
└─────────┬───────────┘
          │
          ▼
┌─────────────────────┐
│ installer-template  │  (Main template with ${VARIABLE} placeholders)
│       .xml          │
└─────────┬───────────┘
          │ includes
          ▼
┌─────────────────────┐
│   components.xml    │  (Files to install)
└─────────┬───────────┘
          │ includes
          ▼
┌─────────────────────┐
│   shortcuts.xml     │  (Desktop/menu shortcuts)
└─────────────────────┘
```

The system uses XML includes and variable substitution:
1. **variables.xml** defines product-specific values
2. **installer-template.xml** references these via `${VARIABLE_NAME}` syntax
3. **components.xml** defines what files to install (included by template)
4. **shortcuts.xml** defines application shortcuts (included by components)

---

## Build Command

```bash
# Build installer for a specific product
builder build installer-template.xml \
    --setvars project_directory=/path/to/InstallBuilder \
    --setvars variablesFile=/path/to/InstallBuilder/products/product-A/variables.xml
```

### Build Examples

**Product A (Windows):**
```bash
builder build installer-template.xml \
    --setvars project_directory=$(pwd) \
    --setvars variablesFile=$(pwd)/products/product-A/variables.xml \
    --platform windows
```

**Product B (Linux):**
```bash
builder build installer-template.xml \
    --setvars project_directory=$(pwd) \
    --setvars variablesFile=$(pwd)/products/product-B/variables.xml \
    --platform linux-x64
```

---

## Variables Reference

### Required Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `PRODUCT_SHORT_NAME` | Short identifier | `ProductA` |
| `PRODUCT_NAME` | Full display name | `Advanced Product A` |
| `PRODUCT_VERSION` | Version number | `1.0.0` |
| `VENDOR_NAME` | Company name | `Keysight Technologies` |
| `SOURCE_DIR` | Source files location | `${project_directory}/../../ProductA/dist` |
| `COMPONENTS_FILE` | Path to components.xml | `${project_directory}/products/product-A/components.xml` |
| `SHORTCUTS_FILE` | Path to shortcuts.xml | `${project_directory}/products/product-A/shortcuts.xml` |
| `LICENSE_FILE` | License file path | `${project_directory}/../../ProductA/LICENSE.txt` |
| `DEFAULT_INSTALL_DIR` | Default installation path | `${platform_install_prefix}/${VENDOR_NAME}/${PRODUCT_SHORT_NAME}` |
| `INSTALLER_FILENAME` | Output installer name | `producta-${PRODUCT_VERSION}-installer` |
| `ENABLED_PLATFORMS` | Target platforms | `windows linux-x64` |

### Windows-Specific Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `WINDOWS_EXECUTABLE` | Main executable | `producta.exe` |
| `WINDOWS_ICON` | Application icon | `producta.ico` |
| `WINDOWS_START_MENU_FOLDER` | Start menu location | `${VENDOR_NAME}\${PRODUCT_SHORT_NAME}` |
| `CREATE_DESKTOP_SHORTCUTS` | Create desktop shortcut (0/1) | `1` |
| `CREATE_START_MENU_SHORTCUTS` | Create start menu shortcut (0/1) | `1` |
| `REGISTRY_KEY` | Registry location | `HKEY_LOCAL_MACHINE\Software\${VENDOR_NAME}\${PRODUCT_SHORT_NAME}` |
| `ADD_TO_PATH_DEFAULT` | Add to PATH (0/1) | `1` |
| `ADD_TO_PATH_POSITION` | PATH position | `end` or `beginning` |

### Linux-Specific Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `LINUX_EXECUTABLE` | Main executable | `producta` |
| `LINUX_ICON` | Application icon | `producta.png` |
| `INSTALL_LINUX_ALIASES` | Install bash aliases (0/1) | `1` |
| `LINUX_ALIAS_FILE` | Alias file location | `~/.bash_aliases` |

### Optional Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `PRODUCT_DESCRIPTION` | Detailed description | `Product A provides advanced simulation...` |
| `PRIVACY_NOTICE_FILE` | Privacy notice path | `${project_directory}/../../ProductA/PRIVACY.txt` |
| `SPLASH_IMAGE` | Installer splash image | `${project_directory}/../../ProductA/splash.png` |
| `README_FILE` | Readme file path | `${project_directory}/../../ProductA/README.txt` |
| `UNINSTALLER_NAME` | Uninstaller executable name | `uninstall-${PRODUCT_SHORT_NAME}` |

---

## Supported Platforms

| Platform | Identifier | Description |
|----------|------------|-------------|
| Windows | `windows` | Windows 7/8/10/11 (32/64-bit) |
| Linux 64-bit | `linux-x64` | Linux x86_64 distributions |

**Note:** This project only supports `windows` and `linux-x64`. Do not use `all` or other platform identifiers.

---

## Adding a New Product

### Step 1: Create Product Directory

```bash
mkdir -p products/my-product
```

### Step 2: Create variables.xml

Copy the template and customize:

```bash
cp variables-template.xml products/my-product/variables.xml
```

Edit the file with your product-specific values.

### Step 3: Create components.xml

Define the files to install:

```xml
<!-- products/my-product/components.xml -->

<!-- Main Component (Always Required) -->
<component>
    <name>main</name>
    <description>Core application files (required)</description>
    <canBeEdited>0</canBeEdited>
    <selected>1</selected>
    <show>1</show>
    <folderList>
        <!-- ======================================== -->
        <!-- =       WINDOWS-SPECIFIC FILES         = -->
        <!-- ======================================== -->
        <folder>
            <description>Windows Core Files</description>
            <destination>${installdir}</destination>
            <name>windowscorefiles</name>
            <platforms>windows</platforms>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/windows</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>

        <!-- ======================================== -->
        <!-- =        LINUX-SPECIFIC FILES          = -->
        <!-- ======================================== -->
        <folder>
            <description>Linux Core Files</description>
            <destination>${installdir}</destination>
            <name>linuxcorefiles</name>
            <platforms>linux-x64</platforms>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/linux</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
    </folderList>

    <!-- Include shortcuts -->
    <shortcutList>
        <include>${SHORTCUTS_FILE}</include>
    </shortcutList>
</component>

<!-- Additional components... -->
```

### Step 4: Create shortcuts.xml

Define application shortcuts:

```xml
<!-- products/my-product/shortcuts.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<shortcutList>

<!-- ============================================================================ -->
<!-- =                        WINDOWS SHORTCUTS                                 = -->
<!-- ============================================================================ -->

<shortcut>
    <comment>Launch ${PRODUCT_NAME}</comment>
    <exec>${installdir}/bin/${WINDOWS_EXECUTABLE}</exec>
    <icon>${installdir}/${WINDOWS_ICON}</icon>
    <name>${PRODUCT_SHORT_NAME}</name>
    <path>${installdir}</path>
    <platforms>windows</platforms>
    <runInTerminal>0</runInTerminal>
    <windowsExec>${installdir}/bin/${WINDOWS_EXECUTABLE}</windowsExec>
    <windowsIcon>${installdir}/${WINDOWS_ICON}</windowsIcon>
    <windowsPath>${installdir}</windowsPath>
    <programGroupAllUsers>1</programGroupAllUsers>
    <programGroupName>${WINDOWS_START_MENU_FOLDER}</programGroupName>
    <windowsCreateDesktopIcon>1</windowsCreateDesktopIcon>
</shortcut>

<!-- ============================================================================ -->
<!-- =                         LINUX SHORTCUTS                                  = -->
<!-- ============================================================================ -->

<shortcut>
    <comment>Launch ${PRODUCT_NAME}</comment>
    <exec>${installdir}/bin/${LINUX_EXECUTABLE}</exec>
    <icon>${installdir}/${LINUX_ICON}</icon>
    <name>${PRODUCT_SHORT_NAME}</name>
    <path>${installdir}</path>
    <platforms>linux-x64</platforms>
    <runInTerminal>0</runInTerminal>
</shortcut>

</shortcutList>
```

### Step 5: Validate

```bash
./validate.sh
```

---

## Validation

The validation script checks:
- XML well-formedness
- XSD schema compliance for variables.xml
- Required variables are defined
- File inclusions exist
- Component-shortcut alignment

### Running Validation

```bash
./validate.sh
```

### Prerequisites

Install xmllint:

```bash
# Ubuntu/Debian
sudo apt install libxml2-utils

# CentOS/RHEL
sudo yum install libxml2

# macOS
brew install libxml2
```

### Validation Output

```
============================================
  InstallBuilder XML Validation
============================================

1. Checking XML Well-formedness
--------------------------------
[PASS] installer-template.xml
[PASS] variables-template.xml
[PASS] products/product-A/variables.xml
[PASS] products/product-A/components.xml
[PASS] products/product-A/shortcuts.xml

1b. Validating Against XSD Schema
----------------------------------
[PASS] variables-template.xml (schema valid)
[PASS] products/product-A/variables.xml (schema valid)

2. Checking Required Variables
-------------------------------
Checking product-A...
  [OK] All required variables defined

3. Checking File Inclusions
----------------------------
[OK] product-A/components.xml
[OK] product-A/shortcuts.xml

============================================
  Validation Summary
============================================
All checks passed!
```

---

## Current Products

| Product | Version | Components | Description |
|---------|---------|------------|-------------|
| **Product A** | 1.0.0 | bin, documentation, solver, python, intelmpi | Advanced simulation with Python scripting and HPC support |
| **Product B** | 2.1.0 | bin, documentation, visual, solver | Visualization and data analysis tools |

### Product A Components

- **main** - Core application files (required)
- **bin** - Binary executables
- **documentation** - User manuals and API docs
- **solver** - Solver libraries
- **python** - Python scripting support (optional)
- **intelmpi** - Intel MPI for HPC (optional)

### Product B Components

- **main** - Core application files (required)
- **bin** - Binary executables
- **documentation** - User guides
- **visual** - Visualization tools
- **solver** - Computational solver

---

## File Organization

All files use clear section markers for platform-specific code:

```xml
<!-- ============================================================================ -->
<!-- =                        WINDOWS SHORTCUTS                                 = -->
<!-- ============================================================================ -->

<!-- Windows shortcuts here -->

<!-- ============================================================================ -->
<!-- =                         LINUX SHORTCUTS                                  = -->
<!-- ============================================================================ -->

<!-- Linux shortcuts here -->
```

This makes it easy to find and modify platform-specific sections.

---

## Related Tasks

### Development Tasks

- [ ] **Set up new product installer**
  - [ ] Create product directory structure
  - [ ] Configure variables.xml with product details
  - [ ] Define components in components.xml
  - [ ] Create shortcuts in shortcuts.xml
  - [ ] Run validation script
  - [ ] Test build on Windows
  - [ ] Test build on Linux

- [ ] **Update product version**
  - [ ] Update `PRODUCT_VERSION` in variables.xml
  - [ ] Update `INSTALLER_FILENAME` if version-specific
  - [ ] Rebuild installers for all platforms
  - [ ] Test installation/uninstallation

- [ ] **Add new component to product**
  - [ ] Add component definition in components.xml
  - [ ] Add platform-specific folders (windows/linux-x64)
  - [ ] Create shortcuts for new component
  - [ ] Update component descriptions
  - [ ] Validate XML files
  - [ ] Test component installation

### Maintenance Tasks

- [ ] **Validate all XML files**
  - [ ] Run `./validate.sh`
  - [ ] Fix any XML well-formedness errors
  - [ ] Fix XSD schema validation errors
  - [ ] Verify all required variables defined
  - [ ] Check file inclusions

- [ ] **Update XSD schema**
  - [ ] Add new elements to schemas/variables.xsd
  - [ ] Set minOccurs for optional elements
  - [ ] Define custom types if needed
  - [ ] Validate existing variables.xml files

- [ ] **Clean up project**
  - [ ] Remove unused product directories
  - [ ] Update documentation
  - [ ] Verify all paths are correct
  - [ ] Check for deprecated variables

### Build Tasks

- [ ] **Build Windows installer**
  - [ ] Set project_directory path
  - [ ] Set variablesFile path
  - [ ] Run builder with --platform windows
  - [ ] Verify output installer created
  - [ ] Test installation on Windows

- [ ] **Build Linux installer**
  - [ ] Set project_directory path
  - [ ] Set variablesFile path
  - [ ] Run builder with --platform linux-x64
  - [ ] Verify output installer created
  - [ ] Test installation on Linux

- [ ] **Release new version**
  - [ ] Update all product versions
  - [ ] Run validation on all products
  - [ ] Build Windows installers
  - [ ] Build Linux installers
  - [ ] Test all installers
  - [ ] Create release notes
  - [ ] Tag release in git

### Testing Tasks

- [ ] **Test Windows installation**
  - [ ] Run installer as administrator
  - [ ] Verify files installed correctly
  - [ ] Check Start Menu shortcuts
  - [ ] Check Desktop shortcuts
  - [ ] Verify PATH updated (if enabled)
  - [ ] Test application launch
  - [ ] Test uninstaller

- [ ] **Test Linux installation**
  - [ ] Run installer with appropriate permissions
  - [ ] Verify files installed correctly
  - [ ] Check desktop shortcuts
  - [ ] Verify bash aliases (if enabled)
  - [ ] Test application launch
  - [ ] Test uninstaller

### Documentation Tasks

- [ ] **Update README**
  - [ ] Add new products to Current Products table
  - [ ] Update variables reference
  - [ ] Add troubleshooting items
  - [ ] Update build examples

- [ ] **Create Confluence page**
  - [ ] Copy README content
  - [ ] Add team-specific information
  - [ ] Add internal links
  - [ ] Set page permissions

---

## Troubleshooting

### Common Issues

**1. xmllint not found**
```bash
sudo apt install libxml2-utils
```

**2. Schema validation fails**
- Check that all required variables are defined in variables.xml
- Ensure boolean values are `0` or `1`
- Verify `ADD_TO_PATH_POSITION` is `beginning` or `end`

**3. Build fails with missing file**
- Verify `SOURCE_DIR` points to correct location
- Check that referenced files exist
- Run `./validate.sh` to identify issues

**4. Shortcuts not appearing**
- Ensure `SHORTCUTS_FILE` path is correct
- Verify shortcuts.xml is included in components.xml
- Check platform identifier matches (`windows` or `linux-x64`)

---

## License

[Your License Here]

---

## Contact

For questions or issues, contact the build team.
