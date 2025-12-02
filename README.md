# InstallBuilder Multi-Product Framework

Modern cross-platform installer framework with product-specific build scripts.

**Status:** Linux Complete ✅ | Windows Ready ⚠️

---

## 🚀 Quick Start

### Build an Installer

```bash
cd InstallBuilder/products/Admore

# Edit paths in build.sh
vim build.sh

# Build
./build.sh linux-x64    # Linux installer
./build.sh windows      # Windows installer
```

### Install

```bash
# GUI mode
./ADM-2024.0-installer.run

# Silent mode
./ADM-2024.0-installer.run --mode unattended --prefix /opt/ESIGroup
```

---

## 📁 Project Structure

```
InstallBuilder/
├── installer-template.xml          # Main installer template
├── variables-template.xml          # Template for new products
├── validate.sh                     # XML validation
├── schemas/variables.xsd           # Validation schema
└── products/
    └── Admore/                     # ADMORE product
        ├── build.sh                ✅ Product build script
        ├── variables.xml           ✅ Product configuration
        ├── components.xml          ✅ Installation components
        └── shortcuts.xml           ✅ Desktop shortcuts
```

---

## 🔧 How It Works

### 1. Build Script (Product-Specific)

Each product has its own `build.sh` with hardcoded paths:

```bash
products/Admore/build.sh
```

**Configuration in build.sh:**
- `APROOTDIR` - Build output directory
- `APROOTNAME` - Package name
- `COMMONROOT` - Scripts and EULA
- `FLEXNETROOT` - FLEXnet runtime
- `IBOUTPUTDIR` - Generated installer output

### 2. Variables (Runtime Configuration)

`variables.xml` defines installer behavior but **NOT build paths**:
- Product info (name, version, vendor)
- UI settings (branding, messages)
- Installation behavior (aliases, shortcuts)
- Platform-specific settings

### 3. Build Process

```
build.sh → Sets paths → Calls builder → Uses variables.xml → Generates installer
```

**Build script responsibilities:**
- Set file paths
- Call InstallBuilder
- Create logs
- Set permissions

**variables.xml responsibilities:**
- Product metadata
- Installer UI/UX
- Post-install actions
- Platform detection

---

## 📦 ADMORE Product

### Build Paths (Edit in build.sh)

```bash
APROOTDIR=/nisprod/packaging/builds/ppg/IBAppPackages
APROOTNAME=ADMORE2024r0_Linux
COMMONROOT=/nisprod/packaging/builds/ppg/IBProjects/00_COMMON_FILES/Content
FLEXNETROOT=/nisprod/packaging/builds/ppg/IBProjects/00_COMMON_FILES/FLEXnet
```

### Required Files

**1. Build Output** (`${APROOTDIR}/${APROOTNAME}/`)
- ADMORE binaries and libraries

**2. Common Root** (`${COMMONROOT}/`)
- `EULA.txt`
- `Paminst-gui.sh`, `auxsh.tar`, `getppgdir.sh`, `install_lic.*`
- `scripts/` directory

**3. Branding** (`${PROJECT_DIR}/Res/`)
- `ADM_Banner.png`, `ADM_Splash.png`, `VIPlatform.png`

**4. FLEXnet** (`${FLEXNETROOT}/`)
- `lmgrd`, `lmutil`, `pam_lmd`

### Linux Features (Modernized)

- ✅ **Automatic PAMHOME setup** - No manual pamcust.sh
- ✅ **Auto .bashrc modification** - Environment configured
- ✅ FLEXnet + Paminst-gui.sh license tool
- ✅ VERSION file (multi-product support)
- ✅ Component selection
- ✅ Bash aliases (automatic)
- ✅ Clean uninstall

### Windows Status

- ✅ Variables defined
- ✅ Components structured
- ✅ Shortcuts configured
- ⚠️ Needs testing

---

## 🆕 Adding a New Product

### 1. Copy Template

```bash
cp -r products/Admore products/NewProduct
cd products/NewProduct
```

### 2. Update build.sh

```bash
vim build.sh
```

Change:
- `PRODUCT_NAME` and `PRODUCT_SHORT_NAME`
- All path variables (APROOTDIR, COMMONROOT, etc.)

### 3. Update variables.xml

```bash
vim variables.xml
```

Change product info:
- `<PRODUCT_SHORT_NAME>`
- `<PRODUCT_NAME>`
- `<PRODUCT_VERSION>`
- `<VENDOR_NAME>`

### 4. Update components.xml

Define what files to install

### 5. Build

```bash
./build.sh linux-x64
```

---

## 🧪 Testing

### Build Test

```bash
cd products/Admore
./build.sh linux-x64
```

### Installation Test

```bash
# GUI
./ADM-2024.0-installer.run

# Silent
./ADM-2024.0-installer.run --mode unattended --prefix /tmp/test-install
```

### Verify Installation

- [ ] Files in install directory
- [ ] VERSION file created
- [ ] Symlink: `/usr/local/bin/ADM`
- [ ] PAMHOME in `~/.bashrc`
- [ ] Aliases in `~/.bash_aliases`
- [ ] Paminst-gui.sh executable

### Uninstall Test

```bash
${installdir}/Uninstall_ESI_Products/uninstall_ADMORE-2024.0
```

Verify cleanup:
- [ ] Files removed
- [ ] VERSION entry removed
- [ ] Symlink removed
- [ ] PAMHOME removed from .bashrc
- [ ] Aliases removed from .bash_aliases

---

## 📋 Build Script vs Variables.xml

### Build Script (build.sh)

**Purpose:** Production environment configuration

**Contains:**
- File system paths
- Build output locations
- Source file locations
- Environment-specific settings

**Changes:** Per deployment environment

### Variables.xml

**Purpose:** Product configuration

**Contains:**
- Product metadata
- Installer UI/UX
- Installation behavior
- Platform detection logic

**Changes:** Per product feature changes

---

## 🔍 Validation

```bash
./validate.sh
```

Checks:
- XML well-formedness
- XSD schema compliance
- Required variables
- File inclusions

---

## 🆘 Troubleshooting

### Build Errors

**Missing files:**
- Check paths in `build.sh`
- Verify files exist
- Use absolute paths

**Builder not found:**
```bash
module load installer/installbuilder
```

### Installation Errors

**VERSION file not created:**
- Check `ENABLE_VERSION_FILE=1` in variables.xml

**Environment not configured:**
- Check .bashrc was modified
- Run `source ~/.bashrc`

---

## 📖 Key Concepts

### Why Separate build.sh and variables.xml?

**build.sh:**
- Deployment-specific (dev, staging, prod)
- File system paths
- Not version controlled with passwords/paths
- Per-environment configuration

**variables.xml:**
- Product-specific
- Version controlled
- Portable across environments
- Product behavior configuration

### Multi-Product Pattern

Each product:
1. Has own directory in `products/`
2. Has own `build.sh` with paths
3. Uses same `installer-template.xml`
4. Generates independent installer

### Legacy Compatibility

- ✅ Replaces pamcust.sh with automatic setup
- ✅ Keeps Paminst-gui.sh for license management
- ✅ Maintains VERSION file pattern
- ✅ Preserves FLEXnet integration

---

**Version:** 1.0.0
**Last Updated:** 2025-12-02
