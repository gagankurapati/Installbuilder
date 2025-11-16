# InstallBuilder Complete Guide

**The Ultimate Guide to Creating Professional Windows and Linux Installers**

A fully dynamic, reusable template for creating professional installers with custom wizards, multi-product support, and zero hardcoded values.

---

## Table of Contents

1. [Quick Start (5 Minutes)](#quick-start-5-minutes)
2. [Features Overview](#features-overview)
3. [Installation Wizard Flow](#installation-wizard-flow)
4. [Files Overview](#files-overview)
5. [Variable Reference](#variable-reference)
6. [Variables Checklist](#variables-checklist)
7. [Multi-Product Support](#multi-product-support)
8. [Components Guide](#components-guide)
9. [Shortcuts Guide](#shortcuts-guide)
10. [Building Installers](#building-installers)
11. [Customization](#customization)
12. [Troubleshooting](#troubleshooting)
13. [Best Practices](#best-practices)

---

## Quick Start (5 Minutes)

### Prerequisites

1. Install InstallBuilder from https://installbuilder.com/
2. Ensure `builder` command is in your PATH

### Step 1: Create Your Product Directory

```bash
cd InstallBuilder
mkdir -p products/my-product
```

### Step 2: Copy Template Files

```bash
# Copy the variables template
cp variables-template.xml products/my-product/variables.xml

# Copy reference component/shortcut files
cp products/product-A/components.xml products/my-product/components.xml
cp products/product-A/shortcuts.xml products/my-product/shortcuts.xml
```

### Step 3: Edit Your Product Variables

Open `products/my-product/variables.xml` and change these essential values:

```xml
<!-- Product Information -->
<PRODUCT_SHORT_NAME>MyApp</PRODUCT_SHORT_NAME>
<PRODUCT_NAME>My Application Name</PRODUCT_NAME>
<PRODUCT_VERSION>1.0.0</PRODUCT_VERSION>
<VENDOR_NAME>Your Company Name</VENDOR_NAME>

<!-- Executables -->
<WINDOWS_EXECUTABLE>myapp.exe</WINDOWS_EXECUTABLE>
<LINUX_EXECUTABLE>myapp</LINUX_EXECUTABLE>
<WINDOWS_ICON>myapp.ico</WINDOWS_ICON>
<LINUX_ICON>myapp.png</LINUX_ICON>

<!-- File Paths -->
<COMPONENTS_FILE>${project_directory}/products/my-product/components.xml</COMPONENTS_FILE>
<SHORTCUTS_FILE>${project_directory}/products/my-product/shortcuts.xml</SHORTCUTS_FILE>
<SOURCE_DIR>${project_directory}/../../MyApp/dist</SOURCE_DIR>
```

### Step 4: Customize Components (Optional)

Edit `products/my-product/components.xml` to define what gets installed. See [Components Guide](#components-guide) below.

### Step 5: Customize Shortcuts (Optional)

Edit `products/my-product/shortcuts.xml` to define Start Menu/Desktop shortcuts. See [Shortcuts Guide](#shortcuts-guide) below.

### Step 6: Build Your Installer

```bash
builder build installer-template.xml --setvars products/my-product/variables.xml
```

**Done!** Your installer will be in the current directory.

---

## Features Overview

### Core Features

✅ **Fully Dynamic** - All values controlled by variables, zero hardcoded values
✅ **Cross-Platform** - Build Windows and Linux installers from one template
✅ **Multi-Product Support** - Manage multiple products without modifying the template
✅ **Professional Wizards** - 9-page installation flow with splash screen
✅ **System Information** - Shows hardware specs and admin status
✅ **Custom Components** - User-selectable features during installation
✅ **Smart Shortcuts** - Platform-specific shortcuts and aliases
✅ **Complete Documentation** - Everything you need in one place

### Platform-Specific Features

**Windows:**
- Desktop shortcut creation
- Start Menu entries with custom folder structure
- Registry entries for Add/Remove Programs
- Add to system PATH option
- Professional uninstaller
- Elevation/admin rights handling

**Linux:**
- Executable permission setting
- Symbolic link creation in /usr/local/bin
- Desktop entries (.desktop files)
- Shell aliases in ~/.bash_aliases
- Proper cleanup on uninstall

---

## Installation Wizard Flow

Your installer will have this professional 9-page flow:

### 1. **Splash Screen**
- Shows your logo/image while installer loads
- Configured via `SPLASH_IMAGE` variable
- Recommended size: 500x300 pixels

### 2. **Welcome Page**
- Welcomes user to installation
- **System Information** button shows:
  - Computer Model
  - Operating System
  - CPU (cores and speed)
  - RAM (total memory)
  - Video Card
  - Screen Resolution
  - User admin privileges status

### 3. **License Agreement Page**
- Displays your EULA (configured via `LICENSE_FILE`)
- **Print** button for printing license
- Radio buttons: "I accept" / "I do not accept"
- **"I do not accept" selected by default**
- Next button disabled until user accepts

### 4. **Privacy Notice Page**
- Scrollable privacy policy (configured via `PRIVACY_NOTICE_FILE`)
- No acceptance required
- Informational only

### 5. **Destination Folder Page**
- Shows default installation path (configured via `DEFAULT_INSTALL_DIR`)
- **Change** button to select custom location
- Shows available disk space

### 6. **Custom Setup Page**
- Tree view of components to install
- Shows component descriptions and sizes
- User can select/deselect optional components
- Required components are grayed out
- **Help**, **Space**, and **Change** buttons

### 7. **Ready to Install Page**
- Summary of installation selections
- Shows installation directory
- Shows components to be installed
- Last chance to go back

### 8. **Installing Page**
- Progress bar with status updates
- Shows current file being installed
- Cancel button available

### 9. **Completion Page**
- **Success**: "Installation Complete" with launch option
- **Cancelled**: "Installation Interrupted" with rollback info

**Navigation:** Every page has Back, Next, and Cancel buttons

---

## Files Overview

### Core Template Files

| File | Description | Modify? |
|------|-------------|---------|
| `installer-template.xml` | Main installer template | ❌ NEVER (for new products) |
| `variables-template.xml` | Template for creating product variables | ✅ Copy for new products |

### Documentation Files

| File | Description |
|------|-------------|
| `COMPLETE_GUIDE.md` | This file - complete documentation |
| `README.md` | Main readme with quick overview |
| `MULTI_PRODUCT_GUIDE.md` | Multi-product configuration guide |
| `COMPONENTS_GUIDE.md` | Component creation guide |
| `SHORTCUTS_README.md` | Shortcut creation guide |
| `VARIABLES_CHECKLIST.md` | Printable checklist |

### Product Configuration Structure

```
products/
├── product-A/
│   ├── components.xml     # Defines what gets installed
│   ├── shortcuts.xml      # Defines Start Menu/Desktop shortcuts
│   └── variables.xml      # Product-specific configuration
└── product-B/
    ├── components.xml
    ├── shortcuts.xml
    └── variables.xml
```

---

## Variable Reference

### Section 1: Project Information (⚠️ REQUIRED)

| Variable | Description | Example |
|----------|-------------|---------|
| `PRODUCT_SHORT_NAME` | Short name (no spaces) | `MyApp` |
| `PRODUCT_NAME` | Display name | `My Application` |
| `PRODUCT_VERSION` | Version number | `1.0.0` |
| `VENDOR_NAME` | Company/vendor name | `Your Company` |
| `PRODUCT_DESCRIPTION` | Detailed description | `Provides comprehensive analysis...` |

### Section 2: Executable Files (⚠️ REQUIRED)

| Variable | Description | Example |
|----------|-------------|---------|
| `WINDOWS_EXECUTABLE` | Windows .exe filename | `myapp.exe` |
| `WINDOWS_ICON` | Windows icon file (.ico) | `myapp.ico` |
| `LINUX_EXECUTABLE` | Linux binary filename | `myapp` |
| `LINUX_ICON` | Linux icon file (.png) | `myapp.png` |

### Section 3: Source File Locations (⚠️ REQUIRED)

| Variable | Description | Example |
|----------|-------------|---------|
| `SOURCE_DIR` | Base directory with app files | `${project_directory}/dist` |
| `PLATFORM_SPECIFIC_DIR` | Platform-neutral files folder | `common` |
| `DOCS_DIR` | Documentation directory | `${project_directory}/docs` |

### Section 3A: External Files (⚠️ REQUIRED)

| Variable | Description | Example |
|----------|-------------|---------|
| `COMPONENTS_FILE` | Path to components.xml | `${project_directory}/products/my-product/components.xml` |
| `SHORTCUTS_FILE` | Path to shortcuts.xml | `${project_directory}/products/my-product/shortcuts.xml` |

### Section 4: License and Legal Files (⚠️ REQUIRED)

| Variable | Description | Example |
|----------|-------------|---------|
| `LICENSE_FILE` | License agreement file | `${project_directory}/LICENSE.txt` |
| `PRIVACY_NOTICE_FILE` | Privacy notice file | `${project_directory}/PRIVACY_NOTICE.txt` |
| `SPLASH_IMAGE` | Splash screen image | `${project_directory}/splash.png` |
| `README_FILE` | Readme file | `${project_directory}/README.txt` |

### Section 5: Installation Directory (⚠️ REQUIRED)

Choose ONE pattern:

```xml
<!-- Pattern 1: Simple (no vendor folder) -->
<!-- Result: C:\Program Files\MyApp -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${PRODUCT_SHORT_NAME}</DEFAULT_INSTALL_DIR>

<!-- Pattern 2: With vendor folder (RECOMMENDED) -->
<!-- Result: C:\Program Files\YourCompany\MyApp -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${VENDOR_NAME}/${PRODUCT_SHORT_NAME}</DEFAULT_INSTALL_DIR>

<!-- Pattern 3: With version (for side-by-side installs) -->
<!-- Result: C:\Program Files\YourCompany\MyApp\1.0.0 -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${VENDOR_NAME}/${PRODUCT_SHORT_NAME}/${PRODUCT_VERSION}</DEFAULT_INSTALL_DIR>
```

### Section 6: Installer Output (⭐ RECOMMENDED)

| Variable | Description | Example |
|----------|-------------|---------|
| `INSTALLER_FILENAME` | Installer filename | `myapp-installer-${PRODUCT_VERSION}` |
| `ENABLED_PLATFORMS` | Target platforms | `windows linux-x64` |

**Platform Options:**
- `windows` - Windows (both 32-bit and 64-bit)
- `linux-x64` - Linux 64-bit (RECOMMENDED)
- `linux` - Linux 32-bit (rarely needed)
- `osx` - macOS
- `all` - All platforms

**Most Common:** `windows linux-x64` (Windows + Linux 64-bit only)

### Section 7: Windows Shortcuts (🔧 OPTIONAL)

| Variable | Description | Default |
|----------|-------------|---------|
| `WINDOWS_START_MENU_FOLDER` | Start Menu folder structure | `${VENDOR_NAME}\${PRODUCT_SHORT_NAME}` |
| `CREATE_DESKTOP_SHORTCUTS` | Create desktop shortcuts | `1` (yes) |
| `CREATE_START_MENU_SHORTCUTS` | Create Start Menu shortcuts | `1` (yes) |

**Start Menu Patterns:**

```xml
<!-- Simple: Start Menu → MyApp -->
<WINDOWS_START_MENU_FOLDER>${PRODUCT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>

<!-- With vendor (RECOMMENDED): Start Menu → YourCompany → MyApp -->
<WINDOWS_START_MENU_FOLDER>${VENDOR_NAME}\${PRODUCT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>

<!-- Multi-level: Start Menu → Engineering → YourCompany → MyApp -->
<WINDOWS_START_MENU_FOLDER>Engineering\${VENDOR_NAME}\${PRODUCT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>
```

### Section 8: Linux Integration (🔧 OPTIONAL)

| Variable | Description | Default |
|----------|-------------|---------|
| `INSTALL_LINUX_ALIASES` | Install shell aliases | `1` (yes) |
| `LINUX_ALIAS_FILE` | Alias file location | `~/.bash_aliases` |

**Example aliases created:**
- `myapp` - Launch application
- `myapp-help` - Show help
- `myapp-config` - Open configuration
- `cd-myapp` - Navigate to install directory

### Section 9: Component Descriptions (⭐ RECOMMENDED)

| Variable | Description |
|----------|-------------|
| `MAIN_COMPONENT_DESCRIPTION` | Main component description |
| `DOCS_COMPONENT_DESCRIPTION` | Documentation component description |

### Section 10: Windows Registry (🔧 OPTIONAL)

| Variable | Description | Default |
|----------|-------------|---------|
| `REGISTRY_KEY` | Registry key path | `HKEY_LOCAL_MACHINE\Software\${VENDOR_NAME}\${PRODUCT_SHORT_NAME}` |

### Section 11: Windows PATH (🔧 OPTIONAL)

| Variable | Description | Default |
|----------|-------------|---------|
| `ADD_TO_PATH_DEFAULT` | Add to PATH by default | `1` (yes) |
| `ADD_TO_PATH_POSITION` | Where to add in PATH | `end` |

### Section 12: Uninstaller (🔧 OPTIONAL)

| Variable | Description | Default |
|----------|-------------|---------|
| `UNINSTALLER_NAME` | Uninstaller executable name | `uninstall-${PRODUCT_SHORT_NAME}` |

---

## Variables Checklist

Use this checklist when creating a new product configuration:

### ⚠️ REQUIRED Variables

- [ ] `PRODUCT_SHORT_NAME` - Short name (no spaces)
- [ ] `PRODUCT_NAME` - Display name
- [ ] `PRODUCT_VERSION` - Version number (e.g., 1.0.0)
- [ ] `VENDOR_NAME` - Company/vendor name
- [ ] `WINDOWS_EXECUTABLE` - Windows .exe filename
- [ ] `WINDOWS_ICON` - Windows icon file (.ico)
- [ ] `LINUX_EXECUTABLE` - Linux binary filename
- [ ] `LINUX_ICON` - Linux icon file (.png)
- [ ] `SOURCE_DIR` - Path to application files
- [ ] `COMPONENTS_FILE` - Path to components.xml
- [ ] `SHORTCUTS_FILE` - Path to shortcuts.xml
- [ ] `LICENSE_FILE` - Path to license file
- [ ] `PRIVACY_NOTICE_FILE` - Path to privacy notice
- [ ] `DEFAULT_INSTALL_DIR` - Installation directory pattern

### ⭐ RECOMMENDED Variables

- [ ] `PRODUCT_DESCRIPTION` - Detailed description
- [ ] `SPLASH_IMAGE` - Splash screen image (500x300 recommended)
- [ ] `DOCS_DIR` - Documentation directory
- [ ] `INSTALLER_FILENAME` - Output filename
- [ ] `WINDOWS_START_MENU_FOLDER` - Start Menu structure
- [ ] `MAIN_COMPONENT_DESCRIPTION` - Main component description
- [ ] `DOCS_COMPONENT_DESCRIPTION` - Documentation description

### 🔧 OPTIONAL Variables (Can Use Defaults)

- [ ] `PLATFORM_SPECIFIC_DIR` - Platform-neutral folder name
- [ ] `ENABLED_PLATFORMS` - Target platforms
- [ ] `CREATE_DESKTOP_SHORTCUTS` - Desktop shortcuts (1/0)
- [ ] `CREATE_START_MENU_SHORTCUTS` - Start Menu shortcuts (1/0)
- [ ] `INSTALL_LINUX_ALIASES` - Linux aliases (1/0)
- [ ] `LINUX_ALIAS_FILE` - Alias file location
- [ ] `REGISTRY_KEY` - Windows registry key
- [ ] `ADD_TO_PATH_DEFAULT` - Add to PATH (1/0)
- [ ] `ADD_TO_PATH_POSITION` - PATH position (beginning/end)
- [ ] `UNINSTALLER_NAME` - Uninstaller name

### Verification Steps

After filling variables:

1. [ ] Check all file paths use `${project_directory}` for relative paths
2. [ ] Verify `SOURCE_DIR` points to actual build output
3. [ ] Confirm `COMPONENTS_FILE` and `SHORTCUTS_FILE` paths are correct
4. [ ] Ensure executable names match actual files
5. [ ] Test that license and privacy files exist
6. [ ] Validate version number format (major.minor.patch)

---

## Multi-Product Support

The XML Include approach allows you to manage multiple products with different components and shortcuts WITHOUT modifying the main template.

### How It Works

#### 1. Main Template Uses XML Includes

The `installer-template.xml` uses variables to point to external files:

```xml
<componentList>
    <include>${COMPONENTS_FILE}</include>
</componentList>
```

Shortcuts are included within the main component:

```xml
<component>
    <name>main</name>
    <shortcutList>
        <include>${SHORTCUTS_FILE}</include>
    </shortcutList>
</component>
```

#### 2. Each Product Defines File Paths

Each product's `variables.xml` points to its specific files:

```xml
<COMPONENTS_FILE>${project_directory}/products/my-product/components.xml</COMPONENTS_FILE>
<SHORTCUTS_FILE>${project_directory}/products/my-product/shortcuts.xml</SHORTCUTS_FILE>
```

#### 3. Build Command Selects Product

```bash
# Build Product A
builder build installer-template.xml --setvars products/product-A/variables.xml

# Build Product B
builder build installer-template.xml --setvars products/product-B/variables.xml
```

### Example: Product A vs Product B

**Product A Components:**
- Main (required)
- Bin (required)
- Documentation (optional)
- Solver (optional)
- **Python** (optional) ← Product A specific
- **Intel MPI** (optional) ← Product A specific

**Product B Components:**
- Main (required)
- Bin (required)
- Documentation (optional)
- **Visual** (optional) ← Product B specific
- Solver (optional)

### Adding a New Product

#### Step 1: Create Product Directory

```bash
mkdir -p products/your-product-name
```

#### Step 2: Copy Template Files

```bash
cp variables-template.xml products/your-product-name/variables.xml
cp products/product-A/components.xml products/your-product-name/components.xml
cp products/product-A/shortcuts.xml products/your-product-name/shortcuts.xml
```

#### Step 3: Edit variables.xml

Update product information and file paths:

```xml
<PRODUCT_SHORT_NAME>YourProduct</PRODUCT_SHORT_NAME>
<PRODUCT_NAME>Your Product Name</PRODUCT_NAME>
<PRODUCT_VERSION>1.0.0</PRODUCT_VERSION>

<COMPONENTS_FILE>${project_directory}/products/your-product-name/components.xml</COMPONENTS_FILE>
<SHORTCUTS_FILE>${project_directory}/products/your-product-name/shortcuts.xml</SHORTCUTS_FILE>

<SOURCE_DIR>${project_directory}/../../YourProduct/dist</SOURCE_DIR>
```

#### Step 4: Customize Components

Edit `products/your-product-name/components.xml` - see [Components Guide](#components-guide) below.

#### Step 5: Customize Shortcuts

Edit `products/your-product-name/shortcuts.xml` - see [Shortcuts Guide](#shortcuts-guide) below.

#### Step 6: Build

```bash
builder build installer-template.xml --setvars products/your-product-name/variables.xml
```

---

## Components Guide

Components define what gets installed. Users can select/deselect optional components in the Custom Setup wizard.

### Component Structure

```xml
<component>
    <!-- REQUIRED: Unique identifier -->
    <name>component_id</name>

    <!-- REQUIRED: Description shown to users -->
    <description>Component description</description>

    <!-- REQUIRED: Can user uncheck? 0=required, 1=optional -->
    <canBeEdited>1</canBeEdited>

    <!-- REQUIRED: Default selection: 1=checked, 0=unchecked -->
    <selected>1</selected>

    <!-- REQUIRED: Show in wizard? 1=visible, 0=hidden -->
    <show>1</show>

    <!-- REQUIRED: Files to install -->
    <folderList>
        <folder>
            <destination>${installdir}/component_folder</destination>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/component_folder</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
    </folderList>

    <!-- OPTIONAL: Conditional installation rules -->
    <shouldPackRuleList>
        <componentTest>
            <logic>exists</logic>
            <name>required_component_id</name>
        </componentTest>
    </shouldPackRuleList>
</component>
```

### Component Property Reference

| Property | Description | Values |
|----------|-------------|--------|
| `name` | Unique identifier | Any string (no spaces recommended) |
| `description` | Text shown in Custom Setup | Any string (use variables like `${MAIN_COMPONENT_DESCRIPTION}`) |
| `canBeEdited` | Can user uncheck? | `0` = required (grayed out), `1` = optional |
| `selected` | Default state | `1` = checked, `0` = unchecked |
| `show` | Visible in wizard? | `1` = visible, `0` = hidden |

### Common Component Patterns

#### Required Component (Always Installed)

```xml
<component>
    <name>core</name>
    <description>Core application files (required)</description>
    <canBeEdited>0</canBeEdited>  <!-- Cannot uncheck -->
    <selected>1</selected>         <!-- Always checked -->
    <show>1</show>                 <!-- Visible but grayed out -->
    <folderList>
        <folder>
            <destination>${installdir}</destination>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/core</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
    </folderList>
</component>
```

#### Optional Component (User Choice, Checked by Default)

```xml
<component>
    <name>documentation</name>
    <description>User guides and API documentation</description>
    <canBeEdited>1</canBeEdited>  <!-- Can uncheck -->
    <selected>1</selected>         <!-- Checked by default -->
    <show>1</show>                 <!-- Visible and clickable -->
    <folderList>
        <folder>
            <destination>${installdir}/docs</destination>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${DOCS_DIR}</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
    </folderList>
</component>
```

#### Optional Component (User Choice, Unchecked by Default)

```xml
<component>
    <name>examples</name>
    <description>Example files and templates</description>
    <canBeEdited>1</canBeEdited>  <!-- Can check/uncheck -->
    <selected>0</selected>         <!-- Unchecked by default -->
    <show>1</show>                 <!-- Visible and clickable -->
    <folderList>
        <folder>
            <destination>${installdir}/examples</destination>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/examples</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
    </folderList>
</component>
```

#### Dependent Component (Requires Another Component)

```xml
<component>
    <name>advanced_tools</name>
    <description>Advanced tools (requires SDK)</description>
    <canBeEdited>1</canBeEdited>
    <selected>0</selected>
    <show>1</show>
    <folderList>
        <folder>
            <destination>${installdir}/tools</destination>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/tools</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
    </folderList>
    <!-- Only install if SDK component is selected -->
    <shouldPackRuleList>
        <componentTest>
            <logic>exists</logic>
            <name>sdk</name>
        </componentTest>
    </shouldPackRuleList>
</component>
```

#### Main Component with Shortcuts

```xml
<component>
    <name>main</name>
    <description>${MAIN_COMPONENT_DESCRIPTION}</description>
    <canBeEdited>0</canBeEdited>
    <selected>1</selected>
    <show>1</show>
    <folderList>
        <folder>
            <destination>${installdir}</destination>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/${PLATFORM_SPECIFIC_DIR}</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
    </folderList>
    <!-- Include shortcuts from external file -->
    <shortcutList>
        <include>${SHORTCUTS_FILE}</include>
    </shortcutList>
</component>
```

### Installing Multiple Directories

```xml
<component>
    <name>database</name>
    <description>Database engine and tools</description>
    <canBeEdited>1</canBeEdited>
    <selected>1</selected>
    <show>1</show>
    <folderList>
        <!-- Database engine files -->
        <folder>
            <destination>${installdir}/database/engine</destination>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/db_engine</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
        <!-- Database tools -->
        <folder>
            <destination>${installdir}/database/tools</destination>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/db_tools</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
        <!-- Database templates -->
        <folder>
            <destination>${installdir}/database/templates</destination>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/db_templates</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
    </folderList>
</component>
```

### Installing Specific Files

```xml
<component>
    <name>config</name>
    <description>Configuration files</description>
    <canBeEdited>0</canBeEdited>
    <selected>1</selected>
    <show>1</show>
    <folderList>
        <folder>
            <destination>${installdir}/config</destination>
            <distributionFileList>
                <!-- Install specific files instead of entire directory -->
                <distributionFile>
                    <origin>${SOURCE_DIR}/config/default.ini</origin>
                </distributionFile>
                <distributionFile>
                    <origin>${SOURCE_DIR}/config/logging.conf</origin>
                </distributionFile>
                <distributionFile>
                    <origin>${SOURCE_DIR}/config/database.xml</origin>
                </distributionFile>
            </distributionFileList>
        </folder>
    </folderList>
</component>
```

### Complete Example: Multi-Component Product

```xml
<componentList>
    <!-- Main Component (Required) -->
    <component>
        <name>main</name>
        <description>${MAIN_COMPONENT_DESCRIPTION}</description>
        <canBeEdited>0</canBeEdited>
        <selected>1</selected>
        <show>1</show>
        <folderList>
            <folder>
                <destination>${installdir}</destination>
                <distributionFileList>
                    <distributionDirectory>
                        <origin>${SOURCE_DIR}/${PLATFORM_SPECIFIC_DIR}</origin>
                    </distributionDirectory>
                </distributionFileList>
            </folder>
        </folderList>
        <shortcutList>
            <include>${SHORTCUTS_FILE}</include>
        </shortcutList>
    </component>

    <!-- Bin Component (Required) -->
    <component>
        <name>bin</name>
        <description>Binary executables and runtime files</description>
        <canBeEdited>0</canBeEdited>
        <selected>1</selected>
        <show>1</show>
        <folderList>
            <folder>
                <destination>${installdir}/bin</destination>
                <distributionFileList>
                    <distributionDirectory>
                        <origin>${SOURCE_DIR}/bin</origin>
                    </distributionDirectory>
                </distributionFileList>
            </folder>
        </folderList>
    </component>

    <!-- Documentation Component (Optional, Checked) -->
    <component>
        <name>documentation</name>
        <description>${DOCS_COMPONENT_DESCRIPTION}</description>
        <canBeEdited>1</canBeEdited>
        <selected>1</selected>
        <show>1</show>
        <folderList>
            <folder>
                <destination>${installdir}/docs</destination>
                <distributionFileList>
                    <distributionDirectory>
                        <origin>${DOCS_DIR}</origin>
                    </distributionDirectory>
                </distributionFileList>
            </folder>
        </folderList>
    </component>

    <!-- Python Component (Optional, Unchecked) -->
    <component>
        <name>python</name>
        <description>Python scripts and libraries for automation</description>
        <canBeEdited>1</canBeEdited>
        <selected>0</selected>
        <show>1</show>
        <folderList>
            <folder>
                <destination>${installdir}/python</destination>
                <distributionFileList>
                    <distributionDirectory>
                        <origin>${SOURCE_DIR}/python</origin>
                    </distributionDirectory>
                </distributionFileList>
            </folder>
        </folderList>
    </component>
</componentList>
```

---

## Shortcuts Guide

Shortcuts define Start Menu entries (Windows), Desktop shortcuts (Windows), and Desktop entries (Linux).

### Shortcut Structure

```xml
<shortcut>
    <!-- REQUIRED: Description shown in tooltip -->
    <comment>Shortcut description</comment>

    <!-- REQUIRED: Executable to launch -->
    <exec>${installdir}/app.exe</exec>

    <!-- RECOMMENDED: Icon file -->
    <icon>${installdir}/app.ico</icon>

    <!-- REQUIRED: Shortcut name shown to user -->
    <name>Application Name</name>

    <!-- REQUIRED: Target platforms -->
    <platforms>windows</platforms>

    <!-- Windows: Start Menu folder -->
    <programGroupName>${WINDOWS_START_MENU_FOLDER}</programGroupName>

    <!-- Run in terminal? 0=GUI, 1=console -->
    <runInTerminal>0</runInTerminal>

    <!-- OPTIONAL: Show only if component installed -->
    <ruleList>
        <componentTest>
            <logic>exists</logic>
            <name>component_name</name>
        </componentTest>
    </ruleList>
</shortcut>
```

### Shortcut Property Reference

| Property | Description | Values |
|----------|-------------|--------|
| `comment` | Tooltip description | Any string |
| `exec` | Executable to launch | Full path to executable |
| `execArgs` | Command-line arguments | Arguments string (optional) |
| `icon` | Icon file | Full path to icon file |
| `name` | Shortcut display name | Any string (can use variables) |
| `platforms` | Target platforms | `windows`, `linux`, `linux-x64`, `all` |
| `programGroupName` | Start Menu folder (Windows) | Folder path (use `\` as separator) |
| `runInTerminal` | Run in terminal? | `0` = GUI, `1` = console |
| `windowsExec` | Windows-specific executable | Path (overrides `exec` on Windows) |
| `linuxExec` | Linux-specific executable | Path (overrides `exec` on Linux) |

### Common Shortcut Patterns

#### Windows GUI Application

```xml
<shortcut>
    <comment>Launch ${PRODUCT_SHORT_NAME}</comment>
    <exec>${installdir}/${WINDOWS_EXECUTABLE}</exec>
    <icon>${installdir}/${WINDOWS_ICON}</icon>
    <name>${PRODUCT_SHORT_NAME}</name>
    <platforms>windows</platforms>
    <programGroupName>${WINDOWS_START_MENU_FOLDER}</programGroupName>
    <runInTerminal>0</runInTerminal>
    <windowsExec>${installdir}/${WINDOWS_EXECUTABLE}</windowsExec>
    <windowsIcon>${installdir}/${WINDOWS_ICON}</windowsIcon>
    <windowsPath>${installdir}</windowsPath>
</shortcut>
```

#### Windows Console Application

```xml
<shortcut>
    <comment>Command-line interface for ${PRODUCT_SHORT_NAME}</comment>
    <exec>${installdir}/bin/tool.exe</exec>
    <name>${PRODUCT_SHORT_NAME} CLI</name>
    <platforms>windows</platforms>
    <programGroupName>${WINDOWS_START_MENU_FOLDER}</programGroupName>
    <runInTerminal>1</runInTerminal>  <!-- Opens in terminal -->
</shortcut>
```

#### Linux Desktop Entry (GUI)

```xml
<shortcut>
    <comment>Launch ${PRODUCT_SHORT_NAME}</comment>
    <exec>${installdir}/${LINUX_EXECUTABLE}</exec>
    <icon>${installdir}/${LINUX_ICON}</icon>
    <name>${PRODUCT_SHORT_NAME}</name>
    <platforms>linux linux-x64</platforms>
    <runInTerminal>0</runInTerminal>
</shortcut>
```

#### Linux Console Application

```xml
<shortcut>
    <comment>Command-line interface</comment>
    <exec>${installdir}/bin/tool</exec>
    <name>${PRODUCT_SHORT_NAME} CLI</name>
    <platforms>linux linux-x64</platforms>
    <runInTerminal>1</runInTerminal>  <!-- Opens in terminal -->
</shortcut>
```

#### Cross-Platform Shortcut

```xml
<shortcut>
    <comment>Launch ${PRODUCT_SHORT_NAME}</comment>
    <exec>${installdir}/${WINDOWS_EXECUTABLE}</exec>
    <icon>${installdir}/${WINDOWS_ICON}</icon>
    <name>${PRODUCT_SHORT_NAME}</name>
    <platforms>all</platforms>
    <programGroupName>${WINDOWS_START_MENU_FOLDER}</programGroupName>
    <runInTerminal>0</runInTerminal>
    <!-- Windows-specific settings -->
    <windowsExec>${installdir}/${WINDOWS_EXECUTABLE}</windowsExec>
    <windowsIcon>${installdir}/${WINDOWS_ICON}</windowsIcon>
    <!-- Linux-specific settings -->
    <linuxExec>${installdir}/${LINUX_EXECUTABLE}</linuxExec>
    <linuxIcon>${installdir}/${LINUX_ICON}</linuxIcon>
</shortcut>
```

#### Conditional Shortcut (Depends on Component)

```xml
<shortcut>
    <comment>Launch Database Manager</comment>
    <exec>${installdir}/database/manager.exe</exec>
    <name>${PRODUCT_SHORT_NAME} Database Manager</name>
    <platforms>windows</platforms>
    <programGroupName>${WINDOWS_START_MENU_FOLDER}</programGroupName>
    <ruleList>
        <!-- Only show if database component is installed -->
        <componentTest>
            <logic>exists</logic>
            <name>database</name>
        </componentTest>
    </ruleList>
</shortcut>
```

#### Documentation Shortcut (Opens in Browser)

Windows:
```xml
<shortcut>
    <comment>View ${PRODUCT_SHORT_NAME} Documentation</comment>
    <exec>${installdir}/docs/index.html</exec>
    <name>${PRODUCT_SHORT_NAME} Documentation</name>
    <platforms>windows</platforms>
    <programGroupName>${WINDOWS_START_MENU_FOLDER}</programGroupName>
    <ruleList>
        <componentTest>
            <logic>exists</logic>
            <name>documentation</name>
        </componentTest>
    </ruleList>
</shortcut>
```

Linux:
```xml
<shortcut>
    <comment>View ${PRODUCT_SHORT_NAME} Documentation</comment>
    <exec>xdg-open</exec>
    <execArgs>${installdir}/docs/index.html</execArgs>
    <name>${PRODUCT_SHORT_NAME} Documentation</name>
    <platforms>linux linux-x64</platforms>
    <ruleList>
        <componentTest>
            <logic>exists</logic>
            <name>documentation</name>
        </componentTest>
    </ruleList>
</shortcut>
```

#### Uninstaller Shortcut (Windows)

```xml
<shortcut>
    <comment>Uninstall ${PRODUCT_SHORT_NAME}</comment>
    <exec>${installdir}/${UNINSTALLER_NAME}.exe</exec>
    <name>Uninstall ${PRODUCT_SHORT_NAME}</name>
    <platforms>windows</platforms>
    <programGroupName>${WINDOWS_START_MENU_FOLDER}</programGroupName>
</shortcut>
```

#### Shortcut with Arguments

```xml
<shortcut>
    <comment>Launch ${PRODUCT_SHORT_NAME} in Debug Mode</comment>
    <exec>${installdir}/${WINDOWS_EXECUTABLE}</exec>
    <execArgs>--debug --verbose</execArgs>
    <icon>${installdir}/${WINDOWS_ICON}</icon>
    <name>${PRODUCT_SHORT_NAME} (Debug)</name>
    <platforms>windows</platforms>
    <programGroupName>${WINDOWS_START_MENU_FOLDER}</programGroupName>
    <runInTerminal>1</runInTerminal>
</shortcut>
```

### Complete Example: Multi-Shortcut Product

```xml
<shortcutList>
    <!-- Main Application (Windows) -->
    <shortcut>
        <comment>Launch ${PRODUCT_SHORT_NAME}</comment>
        <exec>${installdir}/${WINDOWS_EXECUTABLE}</exec>
        <icon>${installdir}/${WINDOWS_ICON}</icon>
        <name>${PRODUCT_SHORT_NAME}</name>
        <platforms>windows</platforms>
        <programGroupName>${WINDOWS_START_MENU_FOLDER}</programGroupName>
        <runInTerminal>0</runInTerminal>
        <windowsExec>${installdir}/${WINDOWS_EXECUTABLE}</windowsExec>
        <windowsIcon>${installdir}/${WINDOWS_ICON}</windowsIcon>
        <windowsPath>${installdir}</windowsPath>
    </shortcut>

    <!-- Main Application (Linux) -->
    <shortcut>
        <comment>Launch ${PRODUCT_SHORT_NAME}</comment>
        <exec>${installdir}/${LINUX_EXECUTABLE}</exec>
        <icon>${installdir}/${LINUX_ICON}</icon>
        <name>${PRODUCT_SHORT_NAME}</name>
        <platforms>linux linux-x64</platforms>
        <runInTerminal>0</runInTerminal>
    </shortcut>

    <!-- Solver Tool (Windows, conditional) -->
    <shortcut>
        <comment>Launch ${PRODUCT_SHORT_NAME} Solver</comment>
        <exec>${installdir}/solver/solver.exe</exec>
        <name>${PRODUCT_SHORT_NAME} Solver</name>
        <platforms>windows</platforms>
        <runInTerminal>1</runInTerminal>
        <programGroupName>${WINDOWS_START_MENU_FOLDER}</programGroupName>
        <ruleList>
            <componentTest>
                <logic>exists</logic>
                <name>solver</name>
            </componentTest>
        </ruleList>
    </shortcut>

    <!-- Documentation (Windows, conditional) -->
    <shortcut>
        <comment>View ${PRODUCT_SHORT_NAME} Documentation</comment>
        <exec>${installdir}/docs/index.html</exec>
        <name>${PRODUCT_SHORT_NAME} Documentation</name>
        <platforms>windows</platforms>
        <programGroupName>${WINDOWS_START_MENU_FOLDER}</programGroupName>
        <ruleList>
            <componentTest>
                <logic>exists</logic>
                <name>documentation</name>
            </componentTest>
        </ruleList>
    </shortcut>

    <!-- Documentation (Linux, conditional) -->
    <shortcut>
        <comment>View ${PRODUCT_SHORT_NAME} Documentation</comment>
        <exec>xdg-open</exec>
        <execArgs>${installdir}/docs/index.html</execArgs>
        <name>${PRODUCT_SHORT_NAME} Documentation</name>
        <platforms>linux linux-x64</platforms>
        <ruleList>
            <componentTest>
                <logic>exists</logic>
                <name>documentation</name>
            </componentTest>
        </ruleList>
    </shortcut>

    <!-- Uninstaller (Windows) -->
    <shortcut>
        <comment>Uninstall ${PRODUCT_SHORT_NAME}</comment>
        <exec>${installdir}/${UNINSTALLER_NAME}.exe</exec>
        <name>Uninstall ${PRODUCT_SHORT_NAME}</name>
        <platforms>windows</platforms>
        <programGroupName>${WINDOWS_START_MENU_FOLDER}</programGroupName>
    </shortcut>
</shortcutList>
```

### Linux Aliases

The template automatically creates Linux shell aliases when `INSTALL_LINUX_ALIASES=1`. These are added to `~/.bash_aliases`:

**Automatically Created Aliases:**
- `${PRODUCT_SHORT_NAME}` → Launch application
- `${PRODUCT_SHORT_NAME}-help` → Show help
- `${PRODUCT_SHORT_NAME}-config` → Open configuration
- `cd-${PRODUCT_SHORT_NAME}` → Navigate to install directory

Example for a product named "MyApp":
```bash
myapp          # Launches /opt/Company/MyApp/myapp
myapp-help     # Shows help
myapp-config   # Opens config
cd-myapp       # cd to /opt/Company/MyApp
```

---

## Building Installers

### Basic Build Commands

```bash
# Build for all enabled platforms
builder build installer-template.xml --setvars products/my-product/variables.xml

# Build Windows only
builder build installer-template.xml --setvars products/my-product/variables.xml --platform windows

# Build Linux 64-bit only
builder build installer-template.xml --setvars products/my-product/variables.xml --platform linux-x64

# Build Linux 32-bit only
builder build installer-template.xml --setvars products/my-product/variables.xml --platform linux

# Custom output directory
builder build installer-template.xml --setvars products/my-product/variables.xml --output-dir ./output
```

### Building Multiple Products

Create a build script:

```bash
#!/bin/bash
# build-all.sh - Build all products

echo "Building Product A..."
builder build installer-template.xml --setvars products/product-A/variables.xml

echo "Building Product B..."
builder build installer-template.xml --setvars products/product-B/variables.xml

echo "Building Product C..."
builder build installer-template.xml --setvars products/product-C/variables.xml

echo "All products built successfully!"
```

### Platform-Specific Batch Builds

```bash
#!/bin/bash
# build-all-windows.sh - Build Windows installers only

for product in products/*/; do
    echo "Building ${product} for Windows..."
    builder build installer-template.xml \
        --setvars ${product}variables.xml \
        --platform windows
done
```

### Override Variables from Command Line

```bash
# Override specific variables without modifying variables.xml
builder build installer-template.xml \
    --setvars products/my-product/variables.xml \
    --setvars PRODUCT_VERSION=2.0.0 \
    --setvars VENDOR_NAME="New Company Name"
```

### GUI Mode

Open the template in InstallBuilder GUI for visual editing:

```bash
builder-gui installer-template.xml --setvars products/my-product/variables.xml
```

### Output Files

After building, you'll find installers in the output directory:

**Windows:**
- `myapp-installer-1.0.0-windows-installer.exe`

**Linux:**
- `myapp-installer-1.0.0-linux-x64-installer.run` (64-bit)
- `myapp-installer-1.0.0-linux-installer.run` (32-bit)

---

## Customization

### Installation Directory Patterns

Choose the pattern that fits your needs in `variables.xml`:

```xml
<!-- Pattern 1: Simple (no vendor folder) -->
<!-- Windows: C:\Program Files\MyApp -->
<!-- Linux: /opt/MyApp -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${PRODUCT_SHORT_NAME}</DEFAULT_INSTALL_DIR>

<!-- Pattern 2: With vendor folder (RECOMMENDED) -->
<!-- Windows: C:\Program Files\YourCompany\MyApp -->
<!-- Linux: /opt/YourCompany/MyApp -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${VENDOR_NAME}/${PRODUCT_SHORT_NAME}</DEFAULT_INSTALL_DIR>

<!-- Pattern 3: With version (for side-by-side installs) -->
<!-- Windows: C:\Program Files\YourCompany\MyApp\1.0.0 -->
<!-- Linux: /opt/YourCompany/MyApp/1.0.0 -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${VENDOR_NAME}/${PRODUCT_SHORT_NAME}/${PRODUCT_VERSION}</DEFAULT_INSTALL_DIR>

<!-- Pattern 4: Custom path -->
<DEFAULT_INSTALL_DIR>C:\MyApps\${PRODUCT_SHORT_NAME}</DEFAULT_INSTALL_DIR>
```

### Start Menu Folder Structure

Control Windows Start Menu organization:

```xml
<!-- Single level: Start Menu → MyApp → shortcuts -->
<WINDOWS_START_MENU_FOLDER>${PRODUCT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>

<!-- With vendor (RECOMMENDED): Start Menu → YourCompany → MyApp → shortcuts -->
<WINDOWS_START_MENU_FOLDER>${VENDOR_NAME}\${PRODUCT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>

<!-- Multi-level: Start Menu → Engineering → YourCompany → MyApp → shortcuts -->
<WINDOWS_START_MENU_FOLDER>Engineering\${VENDOR_NAME}\${PRODUCT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>
```

### Directory Structure Best Practices

**Recommended Source Layout:**

```
project/
├── InstallBuilder/
│   ├── installer-template.xml
│   ├── variables-template.xml
│   ├── COMPLETE_GUIDE.md
│   └── products/
│       ├── product-A/
│       │   ├── components.xml
│       │   ├── shortcuts.xml
│       │   └── variables.xml
│       └── product-B/
│           ├── components.xml
│           ├── shortcuts.xml
│           └── variables.xml
├── dist/                        # Application files
│   ├── common/                  # Shared files
│   │   ├── config/
│   │   └── resources/
│   ├── windows/
│   │   ├── myapp.exe
│   │   ├── myapp.ico
│   │   └── *.dll
│   └── linux/
│       ├── myapp
│       ├── myapp.png
│       └── lib/
├── docs/
│   ├── user-guide.pdf
│   └── api-docs/
├── LICENSE.txt
└── README.txt
```

### Build for Different Environments

Create multiple variable files for different builds:

```bash
# Production build
builder build installer-template.xml --setvars variables-production.xml

# Development build
builder build installer-template.xml --setvars variables-development.xml

# Enterprise build
builder build installer-template.xml --setvars variables-enterprise.xml
```

---

## Troubleshooting

### Common Issues and Solutions

#### Issue: "Variable COMPONENTS_FILE not defined"

**Cause:** Your product's variables.xml is missing the component file path.

**Fix:** Add to your variables.xml:
```xml
<COMPONENTS_FILE>${project_directory}/products/your-product/components.xml</COMPONENTS_FILE>
<SHORTCUTS_FILE>${project_directory}/products/your-product/shortcuts.xml</SHORTCUTS_FILE>
```

#### Issue: "File not found" when building

**Cause:** Component or shortcut file path is incorrect.

**Fix:** Check that paths use `${project_directory}` correctly:
```xml
<!-- CORRECT -->
<COMPONENTS_FILE>${project_directory}/products/product-A/components.xml</COMPONENTS_FILE>

<!-- INCORRECT (missing ${project_directory}) -->
<COMPONENTS_FILE>products/product-A/components.xml</COMPONENTS_FILE>
```

#### Issue: "Source directory not found" error

**Cause:** `SOURCE_DIR` path doesn't exist or is incorrect.

**Fix:** Verify the path:
```bash
# Check if source directory exists
ls -la /path/to/SOURCE_DIR

# Use absolute paths or ${project_directory} for relative paths
<SOURCE_DIR>${project_directory}/../../YourApp/dist</SOURCE_DIR>
```

#### Issue: Shortcuts not appearing

**Cause:** Shortcuts are not included in the main component.

**Fix:** Ensure your main component in `components.xml` includes:
```xml
<component>
    <name>main</name>
    ...
    <shortcutList>
        <include>${SHORTCUTS_FILE}</include>  <!-- This line is required -->
    </shortcutList>
</component>
```

#### Issue: Component files not being installed

**Cause:** Source directory doesn't exist or is incorrectly specified.

**Fix:** Verify `<origin>` paths in `components.xml` match your file structure:
```xml
<distributionDirectory>
    <origin>${SOURCE_DIR}/bin</origin>  <!-- Make sure this directory exists -->
</distributionDirectory>
```

#### Issue: Wrong product files included

**Cause:** Built with wrong variables file.

**Fix:** Always specify the correct product's variables file:
```bash
# CORRECT - Product A
builder build installer-template.xml --setvars products/product-A/variables.xml

# INCORRECT - Will use wrong product files
builder build installer-template.xml --setvars products/product-B/variables.xml
```

#### Issue: Installer doesn't include all files

**Cause:** Platform-specific folder structure doesn't match.

**Fix:** Verify folder names in source directory:
```bash
# Check your source directory structure
ls -la dist/
# Should show: common/ windows/ linux/

# Or adjust PLATFORM_SPECIFIC_DIR in variables.xml
<PLATFORM_SPECIFIC_DIR>common</PLATFORM_SPECIFIC_DIR>
```

#### Issue: Permission denied on Linux

**Cause:** Executable permissions not set properly.

**Fix:** The template handles this automatically, but verify in installer-template.xml:
```xml
<changePermissions>
    <permissions>0755</permissions>
    <files>${installdir}/${LINUX_EXECUTABLE}</files>
</changePermissions>
```

#### Issue: Variables not being substituted

**Cause:** Variable name typo or not defined.

**Fix:**
1. Check spelling: `${PRODUCT_SHORT_NAME}` not `${PROJECT_SHORTNAME}`
2. Verify variable is defined in variables.xml
3. Check that you're using `--setvars` in build command

---

## Best Practices

### 1. Naming Conventions

**Component Names:**
- Good: `python`, `solver`, `documentation`, `database`
- Bad: `comp1`, `comp2`, `extra`

**Shortcut Names:**
- Use variables: `${PRODUCT_SHORT_NAME}` not hardcoded "MyApp"
- Be descriptive: `${PRODUCT_SHORT_NAME} Solver` not just `Solver`

### 2. Component Organization

**Keep Main Component Simple:**
- Only include common/core files in main component
- Don't make main component too large
- Use separate components for optional features

**Use Meaningful Descriptions:**
```xml
<!-- Good -->
<description>Python scripting libraries and automation tools</description>

<!-- Bad -->
<description>Python stuff</description>
```

### 3. Conditional Shortcuts

Always use `<componentTest>` for shortcuts that depend on optional components:

```xml
<shortcut>
    <comment>Python Console</comment>
    <exec>${installdir}/python/python.exe</exec>
    <name>${PRODUCT_SHORT_NAME} Python</name>
    <platforms>windows</platforms>
    <programGroupName>${WINDOWS_START_MENU_FOLDER}</programGroupName>
    <ruleList>
        <componentTest>
            <logic>exists</logic>
            <name>python</name>  <!-- Only show if python component installed -->
        </componentTest>
    </ruleList>
</shortcut>
```

This prevents broken shortcuts if user didn't install the component.

### 4. Test Both Platforms

- Always build and test Windows and Linux installers separately
- Verify shortcuts work on both platforms
- Check file permissions on Linux
- Test uninstaller on both platforms

### 5. Version Management

**Use Semantic Versioning:**
- Format: `MAJOR.MINOR.PATCH` (e.g., `1.0.0`, `2.1.3`)
- Increment MAJOR for breaking changes
- Increment MINOR for new features
- Increment PATCH for bug fixes

**Consider Version in Install Path:**
```xml
<!-- Allows side-by-side installations -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${VENDOR_NAME}/${PRODUCT_SHORT_NAME}/${PRODUCT_VERSION}</DEFAULT_INSTALL_DIR>
```

### 6. Product Organization

**Keep Products Well-Organized:**
```
products/
├── product-A/          # Clear, descriptive names
│   ├── components.xml
│   ├── shortcuts.xml
│   └── variables.xml
├── product-B/
│   ├── components.xml
│   ├── shortcuts.xml
│   └── variables.xml
└── product-C-enterprise/  # Can include variant in name
    ├── components.xml
    ├── shortcuts.xml
    └── variables.xml
```

### 7. Documentation

**Document Your Components:**
- Write clear descriptions users will see
- Mention size estimates if components are large
- Explain what each component does

**Document Dependencies:**
```xml
<component>
    <name>advanced_tools</name>
    <description>Advanced tools (requires SDK component)</description>
    ...
    <shouldPackRuleList>
        <componentTest>
            <logic>exists</logic>
            <name>sdk</name>
        </componentTest>
    </shouldPackRuleList>
</component>
```

### 8. File Paths

**Always Use Variables:**
```xml
<!-- Good -->
<exec>${installdir}/${WINDOWS_EXECUTABLE}</exec>

<!-- Bad -->
<exec>${installdir}/myapp.exe</exec>
```

**Use ${project_directory} for Relative Paths:**
```xml
<!-- Good -->
<SOURCE_DIR>${project_directory}/../../MyApp/dist</SOURCE_DIR>

<!-- Bad (absolute path, not portable) -->
<SOURCE_DIR>/home/user/MyApp/dist</SOURCE_DIR>
```

### 9. Default Selections

**Required Components:**
- `canBeEdited="0"` and `selected="1"`
- Ensures essential files are always installed

**Recommended Optional Components:**
- `canBeEdited="1"` and `selected="1"`
- Checked by default, but user can uncheck

**Optional Components:**
- `canBeEdited="1"` and `selected="0"`
- Unchecked by default, user must opt-in

### 10. Build Automation

**Create Build Scripts:**
```bash
#!/bin/bash
# build.sh - Automated build script

PRODUCT=$1
PLATFORM=${2:-all}

if [ -z "$PRODUCT" ]; then
    echo "Usage: ./build.sh <product-name> [platform]"
    echo "Example: ./build.sh product-A windows"
    exit 1
fi

echo "Building ${PRODUCT} for ${PLATFORM}..."
builder build installer-template.xml \
    --setvars products/${PRODUCT}/variables.xml \
    --platform ${PLATFORM}

echo "Build complete!"
```

---

## Summary

### What You Get

✅ **One Template, All Products** - Never modify installer-template.xml for new products
✅ **Professional 9-Page Wizard** - Splash, welcome, license, privacy, destination, components, ready, installing, complete
✅ **Multi-Product Support** - Use XML includes for product-specific components and shortcuts
✅ **Fully Dynamic** - Zero hardcoded values, everything controlled by variables
✅ **Cross-Platform** - Single template builds Windows and Linux installers
✅ **Component System** - Required and optional components with dependencies
✅ **Smart Shortcuts** - Platform-specific shortcuts with conditional display
✅ **Complete Documentation** - Everything you need in one guide

### To Create a New Product

1. Create `products/new-product/` directory
2. Copy and customize `components.xml`, `shortcuts.xml`, `variables.xml`
3. Build: `builder build installer-template.xml --setvars products/new-product/variables.xml`

That's it! The template handles everything else automatically.

### Key Files

| File | Purpose |
|------|---------|
| `installer-template.xml` | Main template (never modify for new products) |
| `variables-template.xml` | Template for creating product variables |
| `products/*/components.xml` | Defines what gets installed |
| `products/*/shortcuts.xml` | Defines shortcuts/aliases |
| `products/*/variables.xml` | Product-specific configuration |

### Support Resources

- **InstallBuilder Docs:** https://installbuilder.com/docs/
- **Forum:** https://installbuilder.com/forums/
- **Examples:** https://installbuilder.com/docs/examples.html

---

**Need help?** Refer to the specific sections above or check the troubleshooting section.

**Happy Building!**
