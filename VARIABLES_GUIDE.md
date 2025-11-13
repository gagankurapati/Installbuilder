# Variables Configuration Guide

## 📋 Two Ways to Configure Variables

You can use either file - both work the same way with the installer template.

---

## Option 1: variables-template.xml ⭐ RECOMMENDED

**Clean, organized, easy-to-follow format with clear sections**

### Features:
- ✅ Clear visual sections (12 sections)
- ✅ Priority markers (⚠️ Required, ⭐ Recommended, 🔧 Optional)
- ✅ Examples for every field
- ✅ Comments explaining what each value does
- ✅ Built-in checklist at the end
- ✅ Multiple patterns with examples
- ✅ Easy to see what needs to be filled

### Structure:
```xml
<!-- ═══════════════════════════════════════════════════════
     SECTION 1: PROJECT INFORMATION (⚠️ REQUIRED)
     ═══════════════════════════════════════════════════════-->

    <!-- ⚠️ Short name (no spaces, used for directories) -->
    <!-- Examples: "MyApp", "SignalAnalyzer" -->
    <PROJECT_SHORT_NAME>MyApp</PROJECT_SHORT_NAME>

    <!-- ⚠️ Full display name (shown to users) -->
    <!-- Examples: "My Application", "Signal Analyzer Pro" -->
    <PROJECT_FULL_NAME>My Application Name</PROJECT_FULL_NAME>

    ...
```

### Best For:
- First-time users
- Teams (easier to understand)
- Quick visual scanning
- Finding what's required vs optional
- Understanding what each variable does

---

## Option 2: variables.xml

**Compact format with all variables in one place**

### Features:
- ✅ Compact and concise
- ✅ All variables visible at once
- ✅ Grouped by category
- ✅ Comments for guidance
- ✅ Good for experienced users

### Structure:
```xml
<!-- ========================================= -->
<!-- PROJECT INFORMATION                       -->
<!-- ========================================= -->

<!-- Short name for the project (no spaces recommended) -->
<PROJECT_SHORT_NAME>MyApp</PROJECT_SHORT_NAME>

<!-- Full display name of the application -->
<PROJECT_FULL_NAME>My Application Name</PROJECT_FULL_NAME>

...
```

### Best For:
- Experienced users
- Quick edits
- Copy-paste from templates
- Minimal visual clutter

---

## 📊 Comparison

| Feature | variables-template.xml | variables.xml |
|---------|----------------------|---------------|
| Visual sections | ✅ Clear with borders | ⚠️ Comments only |
| Priority markers | ✅ ⚠️⭐🔧 symbols | ❌ None |
| Examples | ✅ Multiple per field | ⚠️ Some fields |
| Explanations | ✅ Detailed | ⚠️ Brief |
| Built-in checklist | ✅ Yes | ❌ No |
| Pattern options | ✅ All uncommented | ⚠️ Choose one |
| File size | Larger (verbose) | Smaller (compact) |
| Readability | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| Best for | Beginners | Experienced |

---

## 🎯 Which Should You Use?

### Use **variables-template.xml** if:
- ✅ You're configuring for the first time
- ✅ You want clear guidance on what to fill
- ✅ You need to see examples
- ✅ You want to know what's required vs optional
- ✅ Multiple people will edit the file
- ✅ You want a checklist

### Use **variables.xml** if:
- ✅ You're experienced with InstallBuilder
- ✅ You prefer compact format
- ✅ You know what all variables mean
- ✅ You're making quick edits
- ✅ You have your own template

---

## 📝 How to Use variables-template.xml

### Step 1: Copy the template
```bash
cp variables-template.xml my-project-variables.xml
```

### Step 2: Open and edit
```bash
# Edit with your favorite editor
nano my-project-variables.xml
# or
code my-project-variables.xml
```

### Step 3: Fill in sections following priority

1. **⚠️ REQUIRED (Must fill these)**
   - Section 1: Project Information
   - Section 2: Executable Files
   - Section 3: Source Locations
   - Section 4: License Files
   - Section 5: Installation Directory

2. **⭐ RECOMMENDED (Should fill these)**
   - Project descriptions
   - Splash image
   - Installer filename
   - Start Menu folder
   - Component descriptions

3. **🔧 OPTIONAL (Can leave as default)**
   - Windows features
   - Linux features
   - Advanced settings

### Step 4: Use the checklist
At the end of the file, there's a checklist:
```xml
<!-- ✅ CHECKLIST - Did you fill in:

     REQUIRED:
     [ ] PROJECT_SHORT_NAME
     [ ] PROJECT_FULL_NAME
     [ ] PROJECT_VERSION
     ...
-->
```

### Step 5: Build
```bash
builder build installer-template.xml --setvars my-project-variables.xml
```

---

## 📋 Additional Resources

### VARIABLES_CHECKLIST.md
**Printable checklist you can use alongside the XML file**

Features:
- All variables listed with checkboxes
- Priority marked (Required/Recommended/Optional)
- Examples for each
- File structure checklist
- Pre-build verification steps
- Quick reference card

**When to use:**
- Print it and check off as you fill variables
- Quick reference while editing
- Team review checklist
- Before building (verification)

---

## 🎨 Visual Guide to variables-template.xml

### 12 Clearly Marked Sections:

```
┌─────────────────────────────────────────────────┐
│ SECTION 1: PROJECT INFORMATION      (⚠️ REQUIRED)│
│ - Project names, version, vendor                │
└─────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────┐
│ SECTION 2: EXECUTABLE FILES         (⚠️ REQUIRED)│
│ - Windows/Linux executables and icons           │
└─────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────┐
│ SECTION 3: SOURCE LOCATIONS          (⚠️ REQUIRED)│
│ - Where your files are located                  │
└─────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────┐
│ SECTION 4: LICENSE FILES             (⚠️ REQUIRED)│
│ - License, privacy notice, splash screen        │
└─────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────┐
│ SECTION 5: INSTALLATION DIRECTORY    (⚠️ REQUIRED)│
│ - Choose installation path pattern              │
└─────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────┐
│ SECTION 6: INSTALLER OUTPUT          (⭐ RECOMMENDED)│
│ - Filename and target platforms                 │
└─────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────┐
│ SECTION 7: WINDOWS SHORTCUTS         (🔧 OPTIONAL)│
│ - Start Menu and Desktop                        │
└─────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────┐
│ SECTION 8: LINUX INTEGRATION         (🔧 OPTIONAL)│
│ - Aliases and desktop entries                   │
└─────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────┐
│ SECTION 9: COMPONENT DESCRIPTIONS    (⭐ RECOMMENDED)│
│ - Text shown in Custom Setup                    │
└─────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────┐
│ SECTION 10: WINDOWS REGISTRY         (🔧 OPTIONAL)│
│ - Registry keys                                  │
└─────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────┐
│ SECTION 11: WINDOWS PATH             (🔧 OPTIONAL)│
│ - Add to system PATH                            │
└─────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────┐
│ SECTION 12: UNINSTALLER              (🔧 OPTIONAL)│
│ - Uninstaller settings                          │
└─────────────────────────────────────────────────┘
```

---

## 💡 Tips for Filling Variables

### 1. Start with Required Sections
Work through sections 1-5 first. These are mandatory.

### 2. Use Real Values
Don't leave placeholder text like "MyApp" or "Your Company"
```xml
❌ <PROJECT_SHORT_NAME>MyApp</PROJECT_SHORT_NAME>
✅ <PROJECT_SHORT_NAME>SignalAnalyzer</PROJECT_SHORT_NAME>
```

### 3. Match File Names Exactly
```xml
<!-- If your exe is called "signal-analyzer.exe" -->
✅ <WINDOWS_EXECUTABLE>signal-analyzer.exe</WINDOWS_EXECUTABLE>
❌ <WINDOWS_EXECUTABLE>signalanalyzer.exe</WINDOWS_EXECUTABLE>
```

### 4. Verify Paths Before Building
```bash
# Check files exist
ls dist/windows/myapp.exe
ls LICENSE.txt
ls PRIVACY_NOTICE.txt
```

### 5. Choose Installation Pattern Carefully
```xml
<!-- For side-by-side installs (recommended) -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${VENDOR_NAME}/${PROJECT_SHORT_NAME}/${PROJECT_VERSION}</DEFAULT_INSTALL_DIR>

<!-- For single install (simpler) -->
<DEFAULT_INSTALL_DIR>${platform_install_prefix}/${VENDOR_NAME}/${PROJECT_SHORT_NAME}</DEFAULT_INSTALL_DIR>
```

### 6. Use Comments for Custom Variables
```xml
<!-- Custom: Using company-specific directory structure -->
<DEFAULT_INSTALL_DIR>C:\Engineering\${VENDOR_NAME}\${PROJECT_SHORT_NAME}</DEFAULT_INSTALL_DIR>
```

---

## 🔄 Converting Between Formats

### From variables.xml to variables-template.xml
1. Copy values from compact file
2. Paste into appropriate sections in template
3. Uncomment chosen patterns

### From variables-template.xml to variables.xml
1. Extract only the `<VARIABLE>value</VARIABLE>` lines
2. Remove comment blocks
3. Keep only uncommented pattern choices

---

## 🎓 Learning Path

### Beginner (Day 1)
1. Read [QUICK_START.md](QUICK_START.md)
2. Use **variables-template.xml**
3. Follow the sections in order
4. Use [VARIABLES_CHECKLIST.md](VARIABLES_CHECKLIST.md)

### Intermediate (Week 1)
1. Read [README.md](README.md)
2. Comfortable with variables-template.xml
3. Customize installation directory
4. Experiment with shortcuts

### Advanced (Month 1)
1. Switch to compact variables.xml
2. Create multiple variable files
3. Add custom components
4. Build automation scripts

---

## ✅ Final Recommendation

**For most users, especially first-time:**
→ Use **variables-template.xml** ⭐

**Rename it to match your project:**
```bash
cp variables-template.xml myapp-variables.xml
# Edit myapp-variables.xml
builder build installer-template.xml --setvars myapp-variables.xml
```

**Keep VARIABLES_CHECKLIST.md handy:**
- Print it or open in another window
- Check off items as you fill them
- Use pre-build verification section

**The clear structure will save you time and prevent errors!**
