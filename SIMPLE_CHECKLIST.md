# Simple Checklist - Just the Fields to Fill

**Quick reference for filling out `variables.xml` for your product installer.**

---

## 🔍 How to Use This

1. Copy `variables-template.xml` to `products/YOUR-PRODUCT/variables.xml`
2. Search for `<!-- TODO:` in your file (13 items total)
3. Fill in each field below
4. Run `./validate.sh` to check

---

## ✅ REQUIRED - Must Fill These

### Product Info (5 fields)
```
PRODUCT_SHORT_NAME      → MyApp (no spaces)
PRODUCT_NAME            → My Application Name
PRODUCT_VERSION         → 1.0.0
VENDOR_NAME             → Your Company Name
PRODUCT_DESCRIPTION     → What your app does
```

### Paths (3 fields)
```
SOURCE_DIR              → Path to your built app files
LICENSE_FILE            → Path to LICENSE.txt
COMPONENTS_FILE         → products/YOUR-PRODUCT/components.xml
SHORTCUTS_FILE          → products/YOUR-PRODUCT/shortcuts.xml
```

### Installer Settings (2 fields)
```
INSTALLER_FILENAME      → myapp-installer (your prefix)
ENABLED_PLATFORMS       → windows | linux-x64 | windows linux-x64
```

### Windows Only (2 fields) - If building for Windows
```
WINDOWS_EXECUTABLE      → myapp.exe
WINDOWS_ICON            → myapp.ico
```

### Linux Only (2 fields) - If building for Linux
```
LINUX_EXECUTABLE        → myapp
LINUX_ICON              → myapp.png
```

**Total Required: 13 fields**

---

## ⚪ OPTIONAL - Can Skip or Remove

```
PRIVACY_NOTICE_FILE     → Path to privacy notice (optional)
SPLASH_IMAGE            → Path to splash screen .png (optional)
README_FILE             → Path to readme.txt (optional)
DOCS_DIR                → Path to docs folder (optional)
```

---

## 📦 Files You Need Before Starting

### Must Have
- [ ] Your application binaries (built/compiled)
- [ ] LICENSE.txt file
- [ ] Windows icon (.ico) - if building for Windows
- [ ] Linux icon (.png) - if building for Linux

### Optional
- [ ] Splash screen image (.png)
- [ ] Privacy notice (.txt)
- [ ] README file (.txt)

---

## ⚡ Quick Steps

```bash
# 1. Create product folder
mkdir -p products/myapp

# 2. Copy template
cp variables-template.xml products/myapp/variables.xml

# 3. Edit the file and search for "TODO"
# Fill in all 13 TODO items

# 4. Create components.xml and shortcuts.xml
# (See README.md for examples)

# 5. Validate
./validate.sh

# 6. Build
builder build installer-template.xml \
    --setvars project_directory=$(pwd) \
    --setvars variablesFile=$(pwd)/products/myapp/variables.xml
```

---

## 🎯 Example - Filled Values

```xml
<PRODUCT_SHORT_NAME>ADMORE</PRODUCT_SHORT_NAME>
<PRODUCT_NAME>ADMORE 2024</PRODUCT_NAME>
<PRODUCT_VERSION>2024.0</PRODUCT_VERSION>
<VENDOR_NAME>Keysight Technologies</VENDOR_NAME>
<PRODUCT_DESCRIPTION>Advanced simulation software</PRODUCT_DESCRIPTION>

<SOURCE_DIR>${project_directory}/../../ADMORE/build</SOURCE_DIR>
<LICENSE_FILE>${project_directory}/../../ADMORE/LICENSE.txt</LICENSE_FILE>
<COMPONENTS_FILE>${project_directory}/products/admore/components.xml</COMPONENTS_FILE>
<SHORTCUTS_FILE>${project_directory}/products/admore/shortcuts.xml</SHORTCUTS_FILE>

<INSTALLER_FILENAME>admore-${PRODUCT_VERSION}-installer</INSTALLER_FILENAME>
<ENABLED_PLATFORMS>windows linux-x64</ENABLED_PLATFORMS>

<WINDOWS_EXECUTABLE>admore.exe</WINDOWS_EXECUTABLE>
<WINDOWS_ICON>admore.ico</WINDOWS_ICON>
<LINUX_EXECUTABLE>admore</LINUX_EXECUTABLE>
<LINUX_ICON>admore.png</LINUX_ICON>
```

---

## 📖 More Help

- **Detailed list:** [FIELDS_TO_FILL.md](FIELDS_TO_FILL.md)
- **Full guide:** [REQUIREMENTS_CHECKLIST.md](REQUIREMENTS_CHECKLIST.md)
- **Complete docs:** [README.md](README.md)

---

**That's it! Just fill 13 fields and you're done.**
