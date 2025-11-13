# Shortcuts Configuration Guide

This guide explains how to manage shortcuts for your InstallBuilder installer.

## Files

1. **shortcuts.xml** - Separate configuration file for managing shortcuts
2. **variables.xml** - Contains shortcut-related variables
3. **installer-template.xml** - Main installer template (includes shortcuts configuration)

## How It Works

### Windows Shortcuts

Windows shortcuts are created in two locations:

1. **Start Menu** - In a folder structure like:
   ```
   Start Menu → [Vendor Name] → [Product Name]
       ├── MyApp.exe
       ├── MyApp Documentation
       └── Uninstall MyApp
   ```

2. **Desktop** - Optional desktop icons

#### Start Menu Folder Configuration

The Start Menu folder structure is controlled by the `WINDOWS_START_MENU_FOLDER` variable in [variables.xml](variables.xml):

```xml
<WINDOWS_START_MENU_FOLDER>${VENDOR_NAME}\${PROJECT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>
```

**Example outputs:**
- `Keysight\MyApp` → Creates folder "Keysight" with subfolder "MyApp"
- `${VENDOR_NAME}` → Creates folder with vendor name only
- `MyCompany\Products\MyApp` → Creates nested folders

#### Windows Shortcut Properties

Each Windows shortcut in [shortcuts.xml](shortcuts.xml) has:

```xml
<shortcut>
    <name>MyApp</name>                          <!-- Shortcut name -->
    <description>Launch MyApp</description>      <!-- Tooltip text -->
    <executable>${installdir}/myapp.exe</executable>
    <icon>${installdir}/myapp.ico</icon>        <!-- Icon file -->
    <workingDirectory>${installdir}</workingDirectory>
    <arguments></arguments>                      <!-- Command line args -->
    <runInTerminal>0</runInTerminal>            <!-- 0=GUI, 1=Console -->
    <createInStartMenu>1</createInStartMenu>    <!-- 1=yes, 0=no -->
    <createOnDesktop>1</createOnDesktop>        <!-- 1=yes, 0=no -->
</shortcut>
```

### Linux Desktop Entries

Linux uses freedesktop.org standard desktop entries. They appear in:
- Application menu
- Desktop (if configured)

#### Linux Desktop Entry Properties

```xml
<desktopEntry>
    <name>MyApp</name>
    <genericName>My Application</genericName>
    <comment>Launch My Application</comment>
    <executable>${installdir}/myapp</executable>
    <icon>${installdir}/myapp.png</icon>
    <categories>Application;Utility;</categories>  <!-- Application menu category -->
    <terminal>false</terminal>                     <!-- true/false -->
    <createDesktopFile>1</createDesktopFile>
</desktopEntry>
```

**Common categories:**
- `Application;Development;` - Development tools
- `Application;Utility;` - Utility applications
- `Application;Office;` - Office applications
- `Application;Graphics;` - Graphics applications
- `Application;Network;` - Network applications

### Linux Shell Aliases

Aliases are added to `~/.bash_aliases` and provide command-line shortcuts.

#### Linux Alias Properties

```xml
<alias>
    <name>myapp</name>
    <command>${installdir}/myapp</command>
    <description>Launch My Application</description>
</alias>
```

**Example aliases created:**
```bash
# After installation, users can run:
myapp                  # Launch the application
myapp-help            # Show help
myapp-config          # Open settings
cd-myapp              # Navigate to installation directory
```

## Configuration Variables

All shortcut-related variables in [variables.xml](variables.xml):

```xml
<!-- Windows Start Menu folder name -->
<WINDOWS_START_MENU_FOLDER>${VENDOR_NAME}\${PROJECT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>

<!-- Create desktop shortcuts by default? (1 = yes, 0 = no) -->
<CREATE_DESKTOP_SHORTCUTS>1</CREATE_DESKTOP_SHORTCUTS>

<!-- Create Start Menu shortcuts by default? (1 = yes, 0 = no) -->
<CREATE_START_MENU_SHORTCUTS>1</CREATE_START_MENU_SHORTCUTS>

<!-- Install Linux aliases by default? (1 = yes, 0 = no) -->
<INSTALL_LINUX_ALIASES>1</INSTALL_LINUX_ALIASES>

<!-- Linux alias file location -->
<LINUX_ALIAS_FILE>~/.bash_aliases</LINUX_ALIAS_FILE>
```

## Customizing Shortcuts

### Adding a New Windows Shortcut

Edit [shortcuts.xml](shortcuts.xml) and add to `<windowsShortcuts>`:

```xml
<shortcut>
    <name>MyApp Tools</name>
    <description>Open MyApp Configuration Tool</description>
    <executable>${installdir}/tools.exe</executable>
    <icon>${installdir}/tools.ico</icon>
    <workingDirectory>${installdir}</workingDirectory>
    <arguments>--config</arguments>
    <runInTerminal>0</runInTerminal>
    <createInStartMenu>1</createInStartMenu>
    <createOnDesktop>0</createOnDesktop>
</shortcut>
```

### Adding a New Linux Alias

Edit [shortcuts.xml](shortcuts.xml) and add to `<linuxAliases>`:

```xml
<alias>
    <name>myapp-logs</name>
    <command>tail -f ${installdir}/logs/app.log</command>
    <description>View MyApp logs in real-time</description>
</alias>
```

### Changing Start Menu Folder Structure

Edit [variables.xml](variables.xml):

```xml
<!-- Single level -->
<WINDOWS_START_MENU_FOLDER>MyCompany Products</WINDOWS_START_MENU_FOLDER>

<!-- Multi-level -->
<WINDOWS_START_MENU_FOLDER>MyCompany\Engineering Tools\${PROJECT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>

<!-- Just product name -->
<WINDOWS_START_MENU_FOLDER>${PROJECT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>
```

## Current Shortcuts Configuration

### Windows Shortcuts
Based on current [installer-template.xml](installer-template.xml):

1. **Main Application** (Start Menu + Desktop)
   - Name: `${PROJECT_SHORT_NAME}`
   - Launches: Main executable
   - Location: Desktop + `Start Menu\${WINDOWS_START_MENU_FOLDER}`

2. **Documentation** (Start Menu only)
   - Name: `${PROJECT_SHORT_NAME} Documentation`
   - Opens: Documentation index.html
   - Location: `Start Menu\${WINDOWS_START_MENU_FOLDER}`
   - Only created if documentation component is installed

3. **Uninstaller** (Start Menu only)
   - Name: `Uninstall ${PROJECT_SHORT_NAME}`
   - Launches: Uninstaller
   - Location: `Start Menu\${WINDOWS_START_MENU_FOLDER}`

### Linux Desktop Entries

1. **Main Application**
   - Name: `${PROJECT_SHORT_NAME}`
   - Creates desktop launcher

2. **Documentation**
   - Name: `${PROJECT_SHORT_NAME} Documentation`
   - Opens documentation in browser
   - Only created if documentation component is installed

### Linux Aliases

The following aliases are automatically created:

```bash
${PROJECT_SHORT_NAME}         # Launch application
${PROJECT_SHORT_NAME}-help    # Show help
${PROJECT_SHORT_NAME}-config  # Open settings
cd-${PROJECT_SHORT_NAME}      # Navigate to install directory
```

## Building the Installer

To build with your shortcuts configuration:

```bash
builder build installer-template.xml --setvars variables.xml
```

The installer will automatically:
1. Create Windows shortcuts in Start Menu and Desktop
2. Create Linux desktop entries
3. Add Linux shell aliases to `~/.bash_aliases`

## User Control

Users can control shortcut creation during installation through the Custom Setup wizard page, which allows them to:
- Choose which components to install
- Select installation location
- Enable/disable optional features

## Uninstallation

When uninstalling:
- **Windows**: All shortcuts are automatically removed from Start Menu and Desktop
- **Linux**: Desktop entries are removed
- **Linux Aliases**: Aliases are removed from `~/.bash_aliases`

## Example: Keysight Product

For a Keysight product called "SignalAnalyzer" version 2.0.0:

**Variables:**
```xml
<VENDOR_NAME>Keysight</VENDOR_NAME>
<PROJECT_SHORT_NAME>SignalAnalyzer</PROJECT_SHORT_NAME>
<PROJECT_FULL_NAME>Keysight Signal Analyzer</PROJECT_FULL_NAME>
<PROJECT_VERSION>2.0.0</PROJECT_VERSION>
```

**Results in:**
- Start Menu: `Keysight\SignalAnalyzer\`
  - SignalAnalyzer
  - SignalAnalyzer Documentation
  - Uninstall SignalAnalyzer
- Desktop: SignalAnalyzer (icon)
- Linux aliases: `signalanalyzer`, `signalanalyzer-help`, etc.

## Tips

1. **Icons**: Use `.ico` format for Windows, `.png` for Linux
2. **Naming**: Keep shortcut names concise and clear
3. **Descriptions**: Provide helpful descriptions for tooltips
4. **Testing**: Test on both Windows and Linux to verify shortcuts work
5. **Folder Structure**: Keep Start Menu folder structure simple (1-2 levels max)
6. **Aliases**: Use lowercase with hyphens for Linux aliases (e.g., `my-app`, not `MyApp`)
