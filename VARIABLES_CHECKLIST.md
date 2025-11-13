# Variables Configuration Checklist

Use this checklist when configuring your installer. Open `variables.xml` and fill in each section.

---

## ⚠️ REQUIRED VARIABLES (Must Fill)

### Project Information
- [ ] `PROJECT_SHORT_NAME` - Short name (no spaces)
  - Example: `MyApp`, `SignalAnalyzer`
  - Used for: Directories, technical names

- [ ] `PROJECT_FULL_NAME` - Full display name
  - Example: `My Application`, `Signal Analyzer Pro`
  - Used for: Installer title, Start Menu

- [ ] `PROJECT_VERSION` - Version number
  - Example: `1.0.0`, `2.5.1`
  - Used for: Installer filename, About dialogs

- [ ] `VENDOR_NAME` - Company/vendor name
  - Example: `Your Company`, `Keysight Technologies`
  - Used for: Installation path, Start Menu folder

### Executable Files
- [ ] `WINDOWS_EXECUTABLE` - Windows .exe file
  - Example: `myapp.exe`
  - Must match file in `dist/windows/`

- [ ] `WINDOWS_ICON` - Windows icon (.ico)
  - Example: `myapp.ico`
  - Must exist in `dist/windows/`

- [ ] `LINUX_EXECUTABLE` - Linux binary
  - Example: `myapp`
  - Must match file in `dist/linux/`

- [ ] `LINUX_ICON` - Linux icon (.png)
  - Example: `myapp.png`
  - Must exist in `dist/linux/`

### File Locations
- [ ] `SOURCE_DIR` - Where your app files are
  - Example: `${project_directory}/dist`
  - Must point to valid directory

- [ ] `LICENSE_FILE` - Your license text
  - Example: `${project_directory}/LICENSE.txt`
  - Must exist (shown in License Agreement page)

- [ ] `PRIVACY_NOTICE_FILE` - Your privacy policy
  - Example: `${project_directory}/PRIVACY_NOTICE.txt`
  - Must exist (shown in Privacy Notice page)

### Installation Directory
- [ ] `DEFAULT_INSTALL_DIR` - Where app installs
  - Choose ONE pattern:
    - Simple: `${platform_install_prefix}/${PROJECT_SHORT_NAME}`
    - With vendor: `${platform_install_prefix}/${VENDOR_NAME}/${PROJECT_SHORT_NAME}`
    - With version: `${platform_install_prefix}/${VENDOR_NAME}/${PROJECT_SHORT_NAME}/${PROJECT_VERSION}`

---

## ⭐ RECOMMENDED VARIABLES (Should Fill)

### Project Details
- [ ] `PROJECT_SUMMARY` - One-line description
  - Shown in installer welcome

- [ ] `PROJECT_DESCRIPTION` - Detailed description
  - Shown in installer pages

### Visual Assets
- [ ] `SPLASH_IMAGE` - Splash screen image
  - Example: `${project_directory}/splash.png`
  - Recommended: 500x300 pixels
  - Format: PNG, JPG, or BMP

### Documentation
- [ ] `DOCS_DIR` - Documentation folder
  - Example: `${project_directory}/docs`
  - Leave empty if no docs: `<DOCS_DIR></DOCS_DIR>`

### Installer Settings
- [ ] `INSTALLER_FILENAME` - Output installer name
  - Example: `myapp-installer-${PROJECT_VERSION}`
  - Result: `myapp-installer-1.0.0-windows-installer.exe`

### Windows Shortcuts
- [ ] `WINDOWS_START_MENU_FOLDER` - Start Menu location
  - Simple: `${PROJECT_SHORT_NAME}`
  - With vendor: `${VENDOR_NAME}\${PROJECT_SHORT_NAME}`
  - Multi-level: `Category\${VENDOR_NAME}\${PROJECT_SHORT_NAME}`

### Component Descriptions
- [ ] `MAIN_COMPONENT_DESCRIPTION`
  - Example: `Main application files (required)`

- [ ] `DOCS_COMPONENT_DESCRIPTION`
  - Example: `Documentation and user guides (optional)`

---

## 🔧 OPTIONAL VARIABLES (Can Leave Default)

### Platforms
- [ ] `ENABLED_PLATFORMS` - Which platforms to build
  - Default: `windows linux linux-x64` (both)
  - Windows only: `windows`
  - Linux only: `linux-x64`

### Source Folders
- [ ] `PLATFORM_SPECIFIC_DIR` - Common files folder
  - Default: `common`
  - Change if your structure is different

- [ ] `README_FILE` - Readme file
  - Default: `${project_directory}/README.txt`

### Windows Features
- [ ] `CREATE_DESKTOP_SHORTCUTS` - Desktop icons
  - Default: `1` (yes)
  - Set to `0` to disable

- [ ] `CREATE_START_MENU_SHORTCUTS` - Start Menu
  - Default: `1` (yes)
  - Set to `0` to disable

- [ ] `ADD_TO_PATH_DEFAULT` - Add to PATH
  - Default: `1` (yes)
  - Set to `0` to disable

- [ ] `ADD_TO_PATH_POSITION` - PATH position
  - Default: `end`
  - Options: `beginning` or `end`

### Linux Features
- [ ] `INSTALL_LINUX_ALIASES` - Shell aliases
  - Default: `1` (yes)
  - Set to `0` to disable

- [ ] `LINUX_ALIAS_FILE` - Alias file location
  - Default: `~/.bash_aliases`

### Advanced
- [ ] `REGISTRY_KEY` - Windows registry path
  - Default: `HKEY_LOCAL_MACHINE\Software\${VENDOR_NAME}\${PROJECT_SHORT_NAME}`

- [ ] `UNINSTALLER_NAME` - Uninstaller name
  - Default: `uninstall-${PROJECT_SHORT_NAME}`

---

## 📁 File Structure Checklist

Before building, verify these files exist:

### Required Files
- [ ] `installer-template.xml` - Main template (don't edit)
- [ ] `variables.xml` - Your edited variables
- [ ] `LICENSE.txt` - Your license
- [ ] `PRIVACY_NOTICE.txt` - Your privacy policy

### Required Directories
- [ ] `dist/common/` - Common files (or your folder name)
- [ ] `dist/windows/` - Windows files
  - [ ] `yourapp.exe` - Windows executable
  - [ ] `yourapp.ico` - Windows icon
- [ ] `dist/linux/` - Linux files
  - [ ] `yourapp` - Linux binary
  - [ ] `yourapp.png` - Linux icon

### Optional Files
- [ ] `splash.png` - Splash screen (500x300 recommended)
- [ ] `README.txt` - Readme file
- [ ] `docs/` - Documentation folder

---

## 🎯 Quick Reference Card

### Essential 5 Variables (Minimum to Change)

```xml
<PROJECT_SHORT_NAME>YourApp</PROJECT_SHORT_NAME>
<PROJECT_FULL_NAME>Your Application</PROJECT_FULL_NAME>
<PROJECT_VERSION>1.0.0</PROJECT_VERSION>
<VENDOR_NAME>Your Company</VENDOR_NAME>
<WINDOWS_EXECUTABLE>yourapp.exe</WINDOWS_EXECUTABLE>
<LINUX_EXECUTABLE>yourapp</LINUX_EXECUTABLE>
```

### Installation Directory Patterns

```xml
<!-- Pattern 1: Simple -->
${platform_install_prefix}/${PROJECT_SHORT_NAME}

<!-- Pattern 2: With Vendor -->
${platform_install_prefix}/${VENDOR_NAME}/${PROJECT_SHORT_NAME}

<!-- Pattern 3: With Version -->
${platform_install_prefix}/${VENDOR_NAME}/${PROJECT_SHORT_NAME}/${PROJECT_VERSION}
```

### Platform Selection

```xml
<!-- Both Windows and Linux -->
<ENABLED_PLATFORMS>windows linux linux-x64</ENABLED_PLATFORMS>

<!-- Windows only -->
<ENABLED_PLATFORMS>windows</ENABLED_PLATFORMS>

<!-- Linux only -->
<ENABLED_PLATFORMS>linux-x64</ENABLED_PLATFORMS>
```

---

## ✅ Pre-Build Verification

Before running the build command, verify:

1. **Variables filled:**
   - [ ] All REQUIRED variables have values
   - [ ] No placeholder text like "MyApp" or "Your Company"
   - [ ] Paths point to actual files/directories

2. **Files exist:**
   - [ ] LICENSE.txt exists
   - [ ] PRIVACY_NOTICE.txt exists
   - [ ] Source files in dist/ folder
   - [ ] Executables and icons present

3. **Paths correct:**
   - [ ] SOURCE_DIR points to your files
   - [ ] LICENSE_FILE path is correct
   - [ ] PRIVACY_NOTICE_FILE path is correct
   - [ ] SPLASH_IMAGE path is correct (if using)

4. **Values match:**
   - [ ] WINDOWS_EXECUTABLE matches actual .exe name
   - [ ] LINUX_EXECUTABLE matches actual binary name
   - [ ] WINDOWS_ICON matches actual .ico file
   - [ ] LINUX_ICON matches actual .png file

---

## 🚀 Build Command

Once all required variables are filled:

```bash
# Build for all platforms
builder build installer-template.xml --setvars variables.xml

# Windows only
builder build installer-template.xml --setvars variables.xml --platform windows

# Linux only
builder build installer-template.xml --setvars variables.xml --platform linux-x64
```

---

## 💡 Tips

1. **Copy variables.xml** before editing (keep a backup)
2. **Use meaningful names** (not "app" or "test")
3. **Test paths** before building (make sure files exist)
4. **Check file names** match between variables and actual files
5. **Use version numbers** in install path for side-by-side installs
6. **Create splash.png** for professional look (500x300 px)
7. **Write clear descriptions** (users will see these)

---

## 📖 More Help

- Quick start: See [QUICK_START.md](QUICK_START.md)
- Full guide: See [README.md](README.md)
- Components: See [COMPONENTS_GUIDE.md](COMPONENTS_GUIDE.md)
- Shortcuts: See [SHORTCUTS_README.md](SHORTCUTS_README.md)
