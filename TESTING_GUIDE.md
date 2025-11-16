# Testing Guide - InstallBuilder Template

This guide shows you how to test the installer template with a minimal test application.

## Prerequisites

1. **InstallBuilder installed**
   ```bash
   # Check if builder command is available
   which builder
   # Should return path like: /opt/installbuilder/bin/builder
   ```

2. **Test application files** (we'll create these)

---

## Quick Test Setup (5 Minutes)

### Step 1: Create Test Application Structure

```bash
# Navigate to parent directory
cd /home/Gagan/work

# Create test application directory
mkdir -p TestApp/dist/common
mkdir -p TestApp/dist/windows
mkdir -p TestApp/dist/linux
mkdir -p TestApp/docs
```

### Step 2: Create Minimal Test Files

```bash
# Create a dummy executable for Windows (text file for testing)
echo "echo Hello from TestApp" > TestApp/dist/windows/testapp.exe
chmod +x TestApp/dist/windows/testapp.exe

# Create a dummy executable for Linux
echo "#!/bin/bash" > TestApp/dist/linux/testapp
echo "echo 'Hello from TestApp'" >> TestApp/dist/linux/testapp
chmod +x TestApp/dist/linux/testapp

# Create dummy icon files
echo "ICON" > TestApp/dist/windows/testapp.ico
echo "ICON" > TestApp/dist/linux/testapp.png

# Create dummy common files
echo "config=test" > TestApp/dist/common/config.ini
echo "# Common Data" > TestApp/dist/common/data.txt

# Create documentation
echo "# TestApp Documentation" > TestApp/docs/index.html
echo "<html><body><h1>TestApp Help</h1></body></html>" >> TestApp/docs/index.html

# Create license and privacy files
echo "MIT License - TestApp" > TestApp/LICENSE.txt
echo "Privacy Notice - We don't collect data" > TestApp/PRIVACY.txt

# Create splash image (just a placeholder text file for testing)
echo "SPLASH" > TestApp/splash.png

# Create README
echo "TestApp - A test application" > TestApp/README.txt
```

### Step 3: Create Test Product Configuration

```bash
cd /home/Gagan/work/InstallBuilder

# Create test product directory
mkdir -p products/test-app

# Copy template files
cp variables-template.xml products/test-app/variables.xml
cp products/product-A/components.xml products/test-app/components.xml
cp products/product-A/shortcuts.xml products/test-app/shortcuts.xml
```

### Step 4: Configure Test Product Variables

Edit `products/test-app/variables.xml`:

```xml
<!-- Essential Information -->
<PROJECT_SHORT_NAME>TestApp</PROJECT_SHORT_NAME>
<PROJECT_FULL_NAME>Test Application</PROJECT_FULL_NAME>
<PROJECT_VERSION>1.0.0</PROJECT_VERSION>
<VENDOR_NAME>TestVendor</VENDOR_NAME>
<PROJECT_SUMMARY>A simple test application</PROJECT_SUMMARY>
<PROJECT_DESCRIPTION>This is a test application to verify the installer template works correctly.</PROJECT_DESCRIPTION>

<!-- Executables -->
<WINDOWS_EXECUTABLE>testapp.exe</WINDOWS_EXECUTABLE>
<WINDOWS_ICON>testapp.ico</WINDOWS_ICON>
<LINUX_EXECUTABLE>testapp</LINUX_EXECUTABLE>
<LINUX_ICON>testapp.png</LINUX_ICON>

<!-- File Paths -->
<SOURCE_DIR>${project_directory}/../../TestApp/dist</SOURCE_DIR>
<DOCS_DIR>${project_directory}/../../TestApp/docs</DOCS_DIR>
<COMPONENTS_FILE>${project_directory}/products/test-app/components.xml</COMPONENTS_FILE>
<SHORTCUTS_FILE>${project_directory}/products/test-app/shortcuts.xml</SHORTCUTS_FILE>

<!-- License Files -->
<LICENSE_FILE>${project_directory}/../../TestApp/LICENSE.txt</LICENSE_FILE>
<PRIVACY_NOTICE_FILE>${project_directory}/../../TestApp/PRIVACY.txt</PRIVACY_NOTICE_FILE>
<SPLASH_IMAGE>${project_directory}/../../TestApp/splash.png</SPLASH_IMAGE>
<README_FILE>${project_directory}/../../TestApp/README.txt</README_FILE>

<!-- Installation Directory -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${VENDOR_NAME}/${PROJECT_SHORT_NAME}</DEFAULT_INSTALL_DIR>

<!-- Installer Output -->
<INSTALLER_FILENAME>testapp-${PROJECT_VERSION}-installer</INSTALLER_FILENAME>
<ENABLED_PLATFORMS>windows linux-x64</ENABLED_PLATFORMS>

<!-- Shortcuts -->
<WINDOWS_START_MENU_FOLDER>${VENDOR_NAME}\${PROJECT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>
<CREATE_DESKTOP_SHORTCUTS>1</CREATE_DESKTOP_SHORTCUTS>
<CREATE_START_MENU_SHORTCUTS>1</CREATE_START_MENU_SHORTCUTS>

<!-- Linux -->
<INSTALL_LINUX_ALIASES>1</INSTALL_LINUX_ALIASES>

<!-- Component Descriptions -->
<MAIN_COMPONENT_DESCRIPTION>Core application files (required)</MAIN_COMPONENT_DESCRIPTION>
<DOCS_COMPONENT_DESCRIPTION>Documentation and help files</DOCS_COMPONENT_DESCRIPTION>

<!-- Uninstaller -->
<UNINSTALLER_NAME>uninstall-${PROJECT_SHORT_NAME}</UNINSTALLER_NAME>
```

### Step 5: Simplify Components for Testing

Edit `products/test-app/components.xml` - keep only main and docs components:

```xml
<componentList>
    <!-- Main Component -->
    <component>
        <name>main</name>
        <description>${MAIN_COMPONENT_DESCRIPTION}</description>
        <canBeEdited>0</canBeEdited>
        <selected>1</selected>
        <show>1</show>
        <folderList>
            <folder>
                <description>Program Files</description>
                <destination>${installdir}</destination>
                <name>programfiles</name>
                <platforms>all</platforms>
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

    <!-- Bin Component -->
    <component>
        <name>bin</name>
        <description>Application executables</description>
        <canBeEdited>0</canBeEdited>
        <selected>1</selected>
        <show>1</show>
        <folderList>
            <folder>
                <destination>${installdir}/bin</destination>
                <distributionFileList>
                    <distributionDirectory>
                        <origin>${SOURCE_DIR}/windows</origin>
                        <platforms>windows</platforms>
                    </distributionDirectory>
                    <distributionDirectory>
                        <origin>${SOURCE_DIR}/linux</origin>
                        <platforms>linux-x64</platforms>
                    </distributionDirectory>
                </distributionFileList>
            </folder>
        </folderList>
    </component>

    <!-- Documentation Component -->
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
</componentList>
```

### Step 6: Build the Test Installer

```bash
cd /home/Gagan/work/InstallBuilder

# Build for all platforms
builder build installer-template.xml --setvars products/test-app/variables.xml

# OR build for specific platform
builder build installer-template.xml --setvars products/test-app/variables.xml --platform windows
builder build installer-template.xml --setvars products/test-app/variables.xml --platform linux-x64
```

---

## Expected Output

After building, you should see:

```
Building installer...
Creating installer for windows...
Creating installer for linux-x64...
Installers created successfully!
```

**Output Files:**
- `testapp-1.0.0-installer-windows-installer.exe`
- `testapp-1.0.0-installer-linux-x64-installer.run`

---

## Testing the Installer

### Windows Testing

1. **Run the installer:**
   ```cmd
   testapp-1.0.0-installer-windows-installer.exe
   ```

2. **Verify wizard pages appear:**
   - [ ] Splash screen
   - [ ] Welcome page with System Information button
   - [ ] License Agreement (must accept to continue)
   - [ ] Privacy Notice
   - [ ] Destination folder selection
   - [ ] Custom Setup (show main, bin, documentation components)
   - [ ] Ready to Install summary
   - [ ] Installing progress bar
   - [ ] Installation Complete

3. **Check installation:**
   - [ ] Files installed to: `C:\Program Files\TestVendor\TestApp\`
   - [ ] Start Menu folder: `Start Menu → TestVendor → TestApp`
   - [ ] Shortcuts created:
     - TestApp (main app)
     - TestApp Documentation
     - Uninstall TestApp
   - [ ] Desktop shortcut created (if enabled)
   - [ ] Registry entry created: `HKEY_LOCAL_MACHINE\Software\TestVendor\TestApp`

4. **Test uninstaller:**
   - Run uninstaller from Start Menu or `C:\Program Files\TestVendor\TestApp\uninstall-TestApp.exe`
   - Verify all files and shortcuts removed

### Linux Testing

1. **Make installer executable:**
   ```bash
   chmod +x testapp-1.0.0-installer-linux-x64-installer.run
   ```

2. **Run the installer:**
   ```bash
   ./testapp-1.0.0-installer-linux-x64-installer.run
   ```

   Or in GUI mode:
   ```bash
   ./testapp-1.0.0-installer-linux-x64-installer.run --mode gtk
   ```

3. **Check installation:**
   ```bash
   # Check files installed
   ls -la /opt/TestVendor/TestApp/

   # Check aliases created
   cat ~/.bash_aliases | grep testapp

   # Reload aliases
   source ~/.bash_aliases

   # Test alias
   testapp
   ```

4. **Verify:**
   - [ ] Files installed to: `/opt/TestVendor/TestApp/`
   - [ ] Desktop entry created: `~/.local/share/applications/`
   - [ ] Shell aliases work:
     - `testapp` - launches app
     - `testapp-help` - shows help
     - `cd-testapp` - navigates to install dir
   - [ ] Executable has correct permissions (755)

5. **Test uninstaller:**
   ```bash
   /opt/TestVendor/TestApp/uninstall
   ```

---

## Automated Test Script

Create `products/test-app/test.sh`:

```bash
#!/bin/bash

echo "=========================================="
echo "InstallBuilder Template Test Script"
echo "=========================================="

# Check prerequisites
echo "1. Checking prerequisites..."
if ! command -v builder &> /dev/null; then
    echo "ERROR: builder command not found. Install InstallBuilder first."
    exit 1
fi
echo "   ✓ InstallBuilder found"

# Check test app structure
echo "2. Checking test application files..."
if [ ! -d "../../TestApp/dist" ]; then
    echo "ERROR: TestApp/dist directory not found"
    echo "Run the setup commands from TESTING_GUIDE.md first"
    exit 1
fi
echo "   ✓ Test application files found"

# Check product configuration
echo "3. Checking product configuration..."
if [ ! -f "variables.xml" ]; then
    echo "ERROR: products/test-app/variables.xml not found"
    exit 1
fi
echo "   ✓ Product configuration found"

# Build installer
echo "4. Building installer..."
cd ../..
builder build installer-template.xml --setvars products/test-app/variables.xml

# Check if build succeeded
if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "BUILD SUCCESSFUL!"
    echo "=========================================="
    echo ""
    echo "Installers created:"
    ls -lh testapp-*.exe testapp-*.run 2>/dev/null
    echo ""
    echo "Test the installers:"
    echo "  Windows: ./testapp-1.0.0-installer-windows-installer.exe"
    echo "  Linux:   ./testapp-1.0.0-installer-linux-x64-installer.run"
else
    echo ""
    echo "=========================================="
    echo "BUILD FAILED!"
    echo "=========================================="
    echo "Check the errors above"
    exit 1
fi
```

Make it executable:
```bash
chmod +x products/test-app/test.sh
```

Run it:
```bash
cd products/test-app
./test.sh
```

---

## Quick Test Checklist

### Pre-Build Checks
- [ ] InstallBuilder installed and `builder` command works
- [ ] Test application files created in `/home/Gagan/work/TestApp/`
- [ ] Product configuration created in `products/test-app/`
- [ ] All required files exist (LICENSE.txt, PRIVACY.txt, splash.png, etc.)

### Build Checks
- [ ] Build command runs without errors
- [ ] Windows installer (.exe) created
- [ ] Linux installer (.run) created
- [ ] File sizes are reasonable (>1MB)

### Installer Checks (Windows)
- [ ] All 9 wizard pages appear
- [ ] License must be accepted before proceeding
- [ ] Components can be selected/deselected
- [ ] Installation completes successfully
- [ ] Files installed to correct location
- [ ] Start Menu shortcuts created
- [ ] Desktop shortcut created
- [ ] Uninstaller works

### Installer Checks (Linux)
- [ ] Installer runs in GUI or text mode
- [ ] Files installed to /opt/TestVendor/TestApp/
- [ ] Executable permissions correct (755)
- [ ] Desktop entry created
- [ ] Shell aliases work
- [ ] Uninstaller removes everything

---

## Troubleshooting

### Build Errors

**Error: "Variable not defined"**
- Check all variables in `products/test-app/variables.xml`
- Ensure no typos in variable names

**Error: "File not found"**
- Verify paths in variables.xml use `${project_directory}`
- Check that TestApp files actually exist:
  ```bash
  ls -R /home/Gagan/work/TestApp/
  ```

**Error: "Cannot include file"**
- Verify COMPONENTS_FILE and SHORTCUTS_FILE paths are correct
- Check files exist:
  ```bash
  ls products/test-app/components.xml
  ls products/test-app/shortcuts.xml
  ```

### Runtime Errors

**Installer won't run on Windows**
- File might be blocked: Right-click → Properties → Unblock

**Installer won't run on Linux**
- Make executable: `chmod +x testapp-*.run`
- Try text mode: `./testapp-*.run --mode text`

**Files not installed**
- Check source directory paths in variables.xml
- Verify origin paths in components.xml match actual file locations

---

## Clean Up Test Files

After testing:

```bash
# Remove test installers
rm testapp-*.exe testapp-*.run

# Remove test application (optional)
rm -rf /home/Gagan/work/TestApp/

# Keep or remove test product configuration (optional)
# rm -rf products/test-app/
```

---

## Next Steps

Once testing passes:

1. **Create your real product configuration:**
   ```bash
   mkdir -p products/your-real-product
   cp variables-template.xml products/your-real-product/variables.xml
   cp products/product-A/components.xml products/your-real-product/components.xml
   cp products/product-A/shortcuts.xml products/your-real-product/shortcuts.xml
   ```

2. **Update with real application files**

3. **Build production installers**

4. **Test on actual Windows and Linux systems**

5. **Distribute to users!**

---

## Quick Command Reference

```bash
# Build test installer
builder build installer-template.xml --setvars products/test-app/variables.xml

# Build Windows only
builder build installer-template.xml --setvars products/test-app/variables.xml --platform windows

# Build Linux only
builder build installer-template.xml --setvars products/test-app/variables.xml --platform linux-x64

# Open in GUI mode
builder-gui installer-template.xml --setvars products/test-app/variables.xml

# Run Windows installer (on Windows)
testapp-1.0.0-installer-windows-installer.exe

# Run Linux installer
chmod +x testapp-1.0.0-installer-linux-x64-installer.run
./testapp-1.0.0-installer-linux-x64-installer.run

# Run Linux installer in text mode
./testapp-1.0.0-installer-linux-x64-installer.run --mode text
```

---

**Testing complete! You now have a working installer template ready for your real applications.**
