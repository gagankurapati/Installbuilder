# Quick Start Guide - 5 Minutes to Your First Installer

## Step 1: Edit variables.xml (2 minutes)

Open `variables.xml` and change these essential values:

```xml
<!-- Change these 8 values at minimum -->
<PROJECT_SHORT_NAME>MyApp</PROJECT_SHORT_NAME>              <!-- Your app name (no spaces) -->
<PROJECT_FULL_NAME>My Application</PROJECT_FULL_NAME>      <!-- Display name -->
<PROJECT_VERSION>1.0.0</PROJECT_VERSION>                    <!-- Version number -->
<VENDOR_NAME>Your Company</VENDOR_NAME>                     <!-- Your company name -->

<WINDOWS_EXECUTABLE>myapp.exe</WINDOWS_EXECUTABLE>          <!-- Your Windows exe -->
<LINUX_EXECUTABLE>myapp</LINUX_EXECUTABLE>                  <!-- Your Linux binary -->
<WINDOWS_ICON>myapp.ico</WINDOWS_ICON>                      <!-- Windows icon file -->
<LINUX_ICON>myapp.png</LINUX_ICON>                          <!-- Linux icon file -->
```

**That's it! Everything else has good defaults.**

## Step 2: Organize Your Files (2 minutes)

Create this structure:

```
your-project/
├── InstallBuilder/
│   ├── installer-template.xml  (don't touch)
│   ├── variables.xml           (your edited file)
│   ├── splash.png              (optional: 500x300 splash screen)
│   ├── LICENSE.txt             (your license)
│   └── PRIVACY_NOTICE.txt      (your privacy policy)
├── dist/
│   ├── common/                 (shared files)
│   ├── windows/                (myapp.exe, myapp.ico, DLLs)
│   └── linux/                  (myapp binary, myapp.png)
└── docs/                       (optional: documentation)
```

## Step 3: Build (1 minute)

```bash
cd InstallBuilder
builder build installer-template.xml --setvars variables.xml
```

**Done!** You now have:
- `myapp-installer-1.0.0-windows-installer.exe`
- `myapp-installer-1.0.0-linux-x64-installer.run`

---

## What You Get

Your installer includes:

### 9 Professional Wizard Pages:
1. ✅ Splash screen (with your logo)
2. ✅ Welcome page with System Information button
3. ✅ License Agreement with Print button
4. ✅ Privacy Notice (scrollable)
5. ✅ Destination Folder selection
6. ✅ Custom Setup (component selection)
7. ✅ Ready to Install summary
8. ✅ Installing with progress bar
9. ✅ Completion message

### Windows Installation:
- ✅ Program files
- ✅ Start Menu folder: `YourCompany\MyApp\`
  - Application shortcut
  - Documentation shortcut
  - Uninstaller shortcut
- ✅ Desktop shortcut (optional)
- ✅ Registry entries
- ✅ Add to PATH (optional)
- ✅ Professional uninstaller

### Linux Installation:
- ✅ Program files
- ✅ Desktop entries (application menu)
- ✅ Shell aliases:
  ```bash
  myapp           # Launch app
  myapp-help      # Show help
  myapp-config    # Settings
  cd-myapp        # Go to install dir
  ```
- ✅ Symbolic link in `/usr/local/bin`
- ✅ Proper permissions

---

## Build Options

```bash
# Build both Windows and Linux
builder build installer-template.xml --setvars variables.xml

# Windows only
builder build installer-template.xml --setvars variables.xml --platform windows

# Linux only
builder build installer-template.xml --setvars variables.xml --platform linux-x64

# Custom output directory
builder build installer-template.xml --setvars variables.xml --output-dir ./output

# Visual editor (GUI)
builder-gui installer-template.xml --setvars variables.xml
```

---

## Common Customizations

### Change Installation Directory Pattern

Edit in `variables.xml`:

```xml
<!-- Option 1: Simple -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${PROJECT_SHORT_NAME}</DEFAULT_INSTALL_DIR>
<!-- Result: C:\Program Files\MyApp -->

<!-- Option 2: With vendor (recommended) -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${VENDOR_NAME}/${PROJECT_SHORT_NAME}</DEFAULT_INSTALL_DIR>
<!-- Result: C:\Program Files\YourCompany\MyApp -->

<!-- Option 3: With version -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${VENDOR_NAME}/${PROJECT_SHORT_NAME}/${PROJECT_VERSION}</DEFAULT_INSTALL_DIR>
<!-- Result: C:\Program Files\YourCompany\MyApp\1.0.0 -->
```

### Change Start Menu Folder

Edit in `variables.xml`:

```xml
<!-- Simple -->
<WINDOWS_START_MENU_FOLDER>${PROJECT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>
<!-- Result: Start Menu → MyApp → shortcuts -->

<!-- With vendor (recommended) -->
<WINDOWS_START_MENU_FOLDER>${VENDOR_NAME}\${PROJECT_SHORT_NAME}</WINDOWS_START_MENU_FOLDER>
<!-- Result: Start Menu → YourCompany → MyApp → shortcuts -->
```

### Disable Desktop Shortcuts

Edit in `variables.xml`:

```xml
<CREATE_DESKTOP_SHORTCUTS>0</CREATE_DESKTOP_SHORTCUTS>  <!-- 0 = disabled, 1 = enabled -->
```

### Disable Linux Aliases

Edit in `variables.xml`:

```xml
<INSTALL_LINUX_ALIASES>0</INSTALL_LINUX_ALIASES>  <!-- 0 = disabled, 1 = enabled -->
```

---

## Testing Your Installer

### Windows
1. Double-click the `.exe` file
2. Go through the wizard
3. Check installation:
   - Files in `C:\Program Files\YourCompany\MyApp\`
   - Start Menu shortcuts
   - Desktop shortcut
   - Registry: `HKEY_LOCAL_MACHINE\SOFTWARE\YourCompany\MyApp`

### Linux
1. Run: `./myapp-installer-1.0.0-linux-x64-installer.run`
2. Go through the wizard
3. Check installation:
   - Files in `/opt/YourCompany/MyApp/`
   - Desktop entry: `~/.local/share/applications/`
   - Aliases: `~/.bash_aliases`
   - Run: `source ~/.bash_aliases` then `myapp`

---

## Need More?

- **Full documentation**: See [README.md](README.md)
- **Add components**: See [COMPONENTS_GUIDE.md](COMPONENTS_GUIDE.md)
- **Customize shortcuts**: See [SHORTCUTS_README.md](SHORTCUTS_README.md)
- **Project overview**: See [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)

---

## Troubleshooting

**"Variable not defined" error**
- Check you edited `variables.xml` correctly
- Make sure all `<VARIABLE_NAME>value</VARIABLE_NAME>` tags are closed

**"Source directory not found"**
- Check `SOURCE_DIR` in `variables.xml`
- Use absolute path or path relative to `installer-template.xml`
- Example: `${project_directory}/dist`

**Files not included**
- Verify your `dist/` folder structure
- Check platform folders: `windows/` and `linux/`
- Ensure files exist in `${SOURCE_DIR}`

**Permission errors on Linux**
- Installer sets permissions automatically
- Make sure executable is in correct folder
- Check `LINUX_EXECUTABLE` matches your binary name

---

## Real-World Example

**Your variables.xml:**
```xml
<PROJECT_SHORT_NAME>SignalPro</PROJECT_SHORT_NAME>
<PROJECT_FULL_NAME>Signal Analyzer Professional</PROJECT_FULL_NAME>
<PROJECT_VERSION>3.2.0</PROJECT_VERSION>
<VENDOR_NAME>TechCorp</VENDOR_NAME>
<WINDOWS_EXECUTABLE>signalpro.exe</WINDOWS_EXECUTABLE>
<LINUX_EXECUTABLE>signalpro</LINUX_EXECUTABLE>
<WINDOWS_ICON>signalpro.ico</WINDOWS_ICON>
<LINUX_ICON>signalpro.png</LINUX_ICON>
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${VENDOR_NAME}/${PROJECT_SHORT_NAME}/${PROJECT_VERSION}</DEFAULT_INSTALL_DIR>
```

**Build:**
```bash
builder build installer-template.xml --setvars variables.xml
```

**Result:**
- Installer: `signalpro-installer-3.2.0-windows-installer.exe`
- Installs to: `C:\Program Files\TechCorp\SignalPro\3.2.0\`
- Start Menu: `TechCorp\SignalPro\`
  - Signal Analyzer Professional
  - Signal Analyzer Professional Documentation
  - Uninstall Signal Analyzer Professional
- Desktop: Signal Analyzer Professional shortcut
- Linux aliases: `signalpro`, `signalpro-help`, etc.

---

## Success Checklist

- [ ] Edited `variables.xml` with your app details
- [ ] Created `dist/windows/` with your .exe and .ico
- [ ] Created `dist/linux/` with your binary and .png
- [ ] Created `LICENSE.txt` file
- [ ] Created `PRIVACY_NOTICE.txt` file (optional)
- [ ] Created `splash.png` (optional, 500x300)
- [ ] Ran build command
- [ ] Got `.exe` and `.run` installers
- [ ] Tested on target platforms

**All done? Congratulations! 🎉**

Your professional installer is ready to distribute!

---

## Next Steps

**For production:**
1. Test installer on clean Windows/Linux VMs
2. Sign your Windows installer (code signing certificate)
3. Test uninstaller
4. Create release notes
5. Distribute!

**For advanced features:**
1. Add more components (SDK, samples, plugins)
2. Customize shortcuts
3. Add post-install actions
4. Create multiple build variants (prod, beta, enterprise)

See the full guides for details!
