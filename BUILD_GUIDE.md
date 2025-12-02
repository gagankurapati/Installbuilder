# ADMORE InstallBuilder - Quick Reference

**Product:** ADMORE 2024.0 | **Vendor:** ESI Group | **Status:** Linux Ready ✅

---

## 🚀 Quick Build

```bash
cd /home/Gagan/work/InstallBuilder

builder build installer-template.xml \
    --setvars project_directory=$(pwd) \
    --setvars variablesFile=$(pwd)/products/Admore/variables.xml \
    --setvars clbuildspace=/path/to/build \
    --setvars clpackage=admore-2024.0 \
    --setvars clmasterpath=/path/to/admore-master \
    --setvars clproductconfigpath=/path/to/admore-config \
    --setvars clflexnetruntimepath=/path/to/flexnet-runtime \
    --platform linux-x64
```

**Replace paths:**
- `clbuildspace` → Your ADMORE build output directory
- `clpackage` → Package subdirectory name
- `clmasterpath` → Scripts and EULA location
- `clproductconfigpath` → Branding images location (Res/ subfolder)
- `clflexnetruntimepath` → FLEXnet runtime files

---

## 📁 Required Files

### 1. Build Output (`${clbuildspace}/${clpackage}/`)
- ADMORE binaries and libraries

### 2. Master Path (`${clmasterpath}/`)
- `EULA.txt`
- `Paminst-gui.sh` (license installation GUI)
- `auxsh.tar`, `getppgdir.sh`, `install_lic.*`
- `scripts/` directory
- Note: `pamcust.sh` no longer needed (automatic setup)

### 3. Branding (`${clproductconfigpath}/Res/`)
- `ADM_Banner.png`, `ADM_Splash.png`, `VIPlatform.png`

### 4. FLEXnet (`${clflexnetruntimepath}/`)
- `lmgrd`, `lmutil`, `pam_lmd`

---

## 📂 Project Structure

```
InstallBuilder/
├── installer-template.xml          # Main installer logic
├── BUILD_GUIDE.md                  # This file (quick reference)
├── validate.sh                     # XML validation
└── products/Admore/
    ├── variables.xml               # ADMORE configuration
    ├── components.xml              # FLEXnet + main components
    └── shortcuts.xml               # Platform-specific shortcuts
```

---

## ✅ Linux Features (Modernized & Complete)

- ✅ **Automatic PAMHOME setup** - No manual pamcust.sh needed
- ✅ **Auto .bashrc modification** - Environment configured automatically
- ✅ FLEXnet component with Paminst-gui.sh license tool
- ✅ VERSION file management (multi-product support)
- ✅ Branding images (4 types)
- ✅ No desktop shortcuts (legacy pattern)
- ✅ Component selection
- ✅ Bash aliases support (automatic)
- ✅ Silent installation
- ✅ Uninstaller in `/Uninstall_ESI_Products/`
- ✅ Clean uninstall (removes all config from .bashrc)

---

## 🔧 Configuration Files

### products/Admore/variables.xml
All ADMORE settings (product info, paths, branding, Linux/Windows separation)

### products/Admore/components.xml
- **flex component:** FLEXnet runtime + scripts
- **default component:** ADMORE package files

### products/Admore/shortcuts.xml
- **Linux:** None (legacy pattern)
- **Windows:** Start Menu + Desktop shortcuts

---

## 🧪 Testing

### Silent Install
```bash
./ADM-2024.0-installer.run --mode unattended --prefix /opt/ESIGroup
```

### Verify
- [ ] Files in `/opt/ESIGroup/`
- [ ] VERSION file created
- [ ] Symlink: `/usr/local/bin/ADM`
- [ ] PAMHOME in `~/.bashrc`
- [ ] Aliases in `~/.bash_aliases`
- [ ] Paminst-gui.sh executable

---

**Last Updated:** 2025-12-01
