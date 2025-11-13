# InstallBuilder Dynamic Installer Template

**A fully dynamic, reusable template for creating professional Windows and Linux installers with custom wizards.**

This template provides a complete installer solution that can be used for ANY application by simply modifying variables. No code changes needed!

## 🎯 Key Features

✅ **Fully Dynamic** - All values controlled by variables
✅ **Cross-Platform** - Windows and Linux from single template
✅ **Professional Wizards** - Splash screen, License, Privacy Notice, Custom Setup, etc.
✅ **System Information** - Shows hardware specs and admin status
✅ **Custom Components** - User-selectable features during installation
✅ **Smart Shortcuts** - Start Menu folders (Windows) and aliases (Linux)
✅ **Complete Documentation** - Guides for shortcuts and components
✅ **No Hardcoded Values** - Everything configurable via variables.xml

## 📁 Files Overview

### Core Files
- **installer-template.xml** - Main installer template (fully dynamic, no hardcoded values)
- **variables.xml** - All configuration in one place
- **variables-template.xml** - Clean template with clear sections and instructions ⭐ **USE THIS**
- **README.md** - This file with complete usage guide

### Quick Reference
- **VARIABLES_CHECKLIST.md** - Printable checklist of all variables ⭐ **HANDY**
- **QUICK_START.md** - 5-minute quick start guide

### Documentation
- **SHORTCUTS_README.md** - Guide for managing shortcuts and aliases
- **COMPONENTS_GUIDE.md** - Guide for adding/modifying installer components
- **shortcuts.xml** - Reference file showing shortcut structure (documentation only)

### Optional Files (Create these for your project)
- **splash.png** - Splash screen image (500x300 recommended)
- **LICENSE.txt** - Your software license
- **PRIVACY_NOTICE.txt** - Privacy policy
- **README.txt** - Project readme

## Prerequisites

1. Install InstallBuilder (https://installbuilder.com/)
2. Ensure `builder` command is available in your PATH

## 🚀 Quick Start (3 Steps to Your Installer!)

### Step 1: Edit variables.xml

**Change only these values** - everything else is automatic!

```xml
<!-- Essential - Change These -->
<PROJECT_SHORT_NAME>YourApp</PROJECT_SHORT_NAME>
<PROJECT_FULL_NAME>Your Application Name</PROJECT_FULL_NAME>
<PROJECT_VERSION>1.0.0</PROJECT_VERSION>
<VENDOR_NAME>Your Company Name</VENDOR_NAME>

<!-- Executables -->
<WINDOWS_EXECUTABLE>yourapp.exe</WINDOWS_EXECUTABLE>
<LINUX_EXECUTABLE>yourapp</LINUX_EXECUTABLE>
<WINDOWS_ICON>yourapp.ico</WINDOWS_ICON>
<LINUX_ICON>yourapp.png</LINUX_ICON>

<!-- Installation Directory (choose one pattern) -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${VENDOR_NAME}/${PROJECT_SHORT_NAME}/${PROJECT_VERSION}</DEFAULT_INSTALL_DIR>
<!-- Result: C:\Program Files\YourCompany\YourApp\1.0.0 -->
```

**See variables.xml for all 30+ configurable options!**

### Step 2: Prepare Your Application Files

Organize your application files in the following structure:

```
your-project/
├── dist/
│   ├── common/         # Platform-neutral files
│   ├── windows/        # Windows-specific files (myapp.exe, myapp.ico)
│   └── linux/          # Linux-specific files (myapp binary, myapp.png)
├── docs/               # Documentation files
├── LICENSE.txt         # License file
└── README.txt          # Readme file
```

### Step 3: Build the Installer

**That's it! Just run:**

```bash
builder build installer-template.xml --setvars variables.xml
```

**Platform-Specific Builds:**

```bash
# Windows only
builder build installer-template.xml --setvars variables.xml --platform windows

# Linux only
builder build installer-template.xml --setvars variables.xml --platform linux-x64

# Custom output directory
builder build installer-template.xml --setvars variables.xml --output-dir ./output
```

**Output:**
- `yourapp-installer-1.0.0-windows-installer.exe`
- `yourapp-installer-1.0.0-linux-x64-installer.run`

## Variable Reference

### Essential Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `PROJECT_SHORT_NAME` | Short name (no spaces) | MyApp |
| `PROJECT_FULL_NAME` | Display name | My Application |
| `PROJECT_VERSION` | Version number | 1.0.0 |
| `VENDOR_NAME` | Company/vendor name | Your Company |
| `SOURCE_DIR` | Path to application files | ./dist |

### Executable Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `WINDOWS_EXECUTABLE` | Windows .exe filename | myapp.exe |
| `LINUX_EXECUTABLE` | Linux binary filename | myapp |
| `WINDOWS_ICON` | Windows icon file | myapp.ico |
| `LINUX_ICON` | Linux icon file | myapp.png |

### Directory Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `DEFAULT_INSTALL_DIR` | Installation directory | ${platform_install_prefix}/${PROJECT_SHORT_NAME} |
| `DOCS_DIR` | Documentation folder | ./docs |

### Platform Selection

Edit `ENABLED_PLATFORMS` in variables.xml:
- `windows` - Windows 32/64-bit
- `linux` - Linux 32-bit
- `linux-x64` - Linux 64-bit
- `osx` - macOS (if needed)
- `all` - All platforms

## 🎨 Installation Wizard Flow

This template creates a professional installer with the following pages:

1. **Splash Screen** - Shows while installer loads (with your logo)
2. **Welcome Page** - With "System Information" button showing:
   - Model, OS, CPU, RAM, Video Card, Screen Resolution
   - User admin privileges status
3. **License Agreement** - EULA with Print button
   - "I accept" / "I do not accept" radio buttons
   - Next button disabled until accepted
4. **Privacy Notice** - Scrollable privacy policy (no acceptance needed)
5. **Destination Folder** - Choose installation location with Change button
6. **Custom Setup** - Select components to install
   - Tree view of available features
   - Shows descriptions and sizes
   - Help, Space, and Change buttons
7. **Ready to Install** - Summary of selections before installation
8. **Installing** - Progress bar with status updates
9. **Installation Complete** - Success message
   - OR **Installation Interrupted** - If cancelled (with rollback)

**Navigation:** Every page has Back, Next, and Cancel buttons

## 📦 What Gets Installed

### Windows
- Program files to selected directory
- Start Menu folder with shortcuts (e.g., `Keysight\YourApp\`)
  - Application shortcut
  - Documentation shortcut
  - Uninstaller shortcut
- Desktop shortcut (optional)
- Registry entries for Add/Remove Programs
- Add to PATH (optional)
- Uninstaller

### Linux
- Program files to selected directory
- Desktop entries for application menu
- Shell aliases in `~/.bash_aliases`:
  - `yourapp` - Launch app
  - `yourapp-help` - Show help
  - `yourapp-config` - Settings
  - `cd-yourapp` - Navigate to install directory
- Symbolic link in `/usr/local/bin`
- Proper permissions on executables

## ✨ Features

### Cross-Platform Support
- Single template builds installers for both Windows and Linux
- Platform-specific files and actions are automatically handled
- Conditional logic for Windows registry, Linux permissions, etc.

### Customizable Components
- **Main Component** - Core application files (required)
- **Documentation Component** - Optional docs and guides (user selectable)

### Windows Features
- Desktop shortcut creation
- Start menu entries
- Registry entries for uninstall information
- Add to system PATH option
- Elevation/admin rights handling
- Professional uninstaller

### Linux Features
- Executable permission setting
- Symbolic link creation in /usr/local/bin
- Desktop shortcut (.desktop file)
- Proper cleanup on uninstall

### User Options
- Custom installation directory
- Add to system PATH (Windows)
- Create desktop shortcut
- Launch application after installation

## Advanced Usage

### Override Variables via Command Line

You can override specific variables without modifying variables.xml:

```bash
builder build installer-template.xml \
  --setvars variables.xml \
  --setvars PROJECT_VERSION=2.0.0 \
  --setvars VENDOR_NAME="New Company Name"
```

### Multiple Variable Files

Create different variable files for different builds:

```bash
# Production build
builder build installer-template.xml --setvars variables-production.xml

# Development build
builder build installer-template.xml --setvars variables-development.xml
```

### GUI Mode

Open the template in InstallBuilder GUI for visual editing:

```bash
builder-gui installer-template.xml --setvars variables.xml
```

## Directory Structure Best Practices

### Recommended Source Layout:

```
project/
├── InstallBuilder/
│   ├── installer-template.xml
│   ├── variables.xml
│   └── README.md
├── dist/
│   ├── common/                 # Shared files
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

## Troubleshooting

### Common Issues

1. **"Variable not defined" error**
   - Ensure all variables in template are defined in variables.xml
   - Check for typos in variable names

2. **"Source directory not found" error**
   - Verify `SOURCE_DIR` path in variables.xml
   - Use absolute paths or paths relative to project file location
   - Use `${project_directory}` for paths relative to template file

3. **Installer doesn't include all files**
   - Check your source directory structure
   - Verify platform-specific folder names (windows/linux)
   - Review `<origin>` paths in template

4. **Permission denied on Linux**
   - Ensure executable permissions are set in source files
   - Verify `changePermissions` action in template

## Output Files

After building, you'll find installers in the output directory:

- **Windows**: `myapp-installer-1.0.0-windows-installer.exe`
- **Linux 64-bit**: `myapp-installer-1.0.0-linux-x64-installer.run`
- **Linux 32-bit**: `myapp-installer-1.0.0-linux-installer.run`

## 🎛️ Customization

### 1. Installation Directory Patterns

Choose your preferred pattern in `variables.xml`:

```xml
<!-- Simple (no vendor folder) -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${PROJECT_SHORT_NAME}</DEFAULT_INSTALL_DIR>
<!-- Result: C:\Program Files\YourApp -->

<!-- With vendor folder -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${VENDOR_NAME}/${PROJECT_SHORT_NAME}</DEFAULT_INSTALL_DIR>
<!-- Result: C:\Program Files\YourCompany\YourApp -->

<!-- With version (recommended for side-by-side installs) -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${VENDOR_NAME}/${PROJECT_SHORT_NAME}/${PROJECT_VERSION}</DEFAULT_INSTALL_DIR>
<!-- Result: C:\Program Files\YourCompany\YourApp\1.0.0 -->
```

### 2. Start Menu Folder Structure

Control Windows Start Menu organization:

```xml
<!-- Single level -->
<WINDOWS_START_MENU_FOLDER>${PROJECT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>
<!-- Result: Start Menu → YourApp → shortcuts -->

<!-- With vendor (recommended) -->
<WINDOWS_START_MENU_FOLDER>${VENDOR_NAME}\${PROJECT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>
<!-- Result: Start Menu → YourCompany → YourApp → shortcuts -->

<!-- Multi-level -->
<WINDOWS_START_MENU_FOLDER>Engineering\${VENDOR_NAME}\${PROJECT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>
<!-- Result: Start Menu → Engineering → YourCompany → YourApp → shortcuts -->
```

### 3. Add Components

See [COMPONENTS_GUIDE.md](COMPONENTS_GUIDE.md) for detailed instructions.

Quick example - add SDK component:
```xml
<component>
    <name>sdk</name>
    <description>SDK and Developer Tools</description>
    <canBeEdited>1</canBeEdited>  <!-- Optional -->
    <selected>0</selected>         <!-- Unchecked by default -->
    <show>1</show>
    <folderList>
        <folder>
            <destination>${installdir}/sdk</destination>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/sdk</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
    </folderList>
</component>
```

### 4. Customize Shortcuts

See [SHORTCUTS_README.md](SHORTCUTS_README.md) for detailed instructions.

The template already includes:
- **Windows**: Main app, Documentation, Uninstaller in Start Menu + Desktop
- **Linux**: Desktop entries and 4 shell aliases

### 5. Build for Different Environments

Create multiple variable files:

```bash
# Production
builder build installer-template.xml --setvars variables-production.xml

# Development/Beta
builder build installer-template.xml --setvars variables-dev.xml

# Enterprise
builder build installer-template.xml --setvars variables-enterprise.xml
```

## Support

For InstallBuilder documentation and support:
- Official Docs: https://installbuilder.com/docs/
- Forum: https://installbuilder.com/forums/
- Examples: https://installbuilder.com/docs/examples.html

## License

Configure your project license in variables.xml by setting the LICENSE_FILE variable.
