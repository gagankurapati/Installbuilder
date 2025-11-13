# Components Guide

This guide explains how to add, modify, and customize components in your InstallBuilder installer.

## What Are Components?

Components are features that users can select or deselect during the "Custom Setup" wizard page. They allow users to customize their installation by choosing which parts of your software to install.

## Component Structure

Each component in `installer-template.xml` has this basic structure:

```xml
<component>
    <name>component_name</name>
    <description>Description shown in Custom Setup</description>
    <canBeEdited>1</canBeEdited>        <!-- 0=required, 1=optional -->
    <selected>1</selected>               <!-- 0=unchecked, 1=checked by default -->
    <show>1</show>                       <!-- 0=hidden, 1=visible -->
    <size>10240</size>                   <!-- Size in KB (optional, auto-calculated) -->

    <!-- Files to install -->
    <folderList>
        <folder>
            <description>Folder description</description>
            <destination>${installdir}/subfolder</destination>
            <name>unique_folder_name</name>
            <platforms>all</platforms>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/source_folder</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
    </folderList>

    <!-- Optional: Shortcuts for this component -->
    <shortcutList>
        <shortcut>...</shortcut>
    </shortcutList>

    <!-- Optional: Actions to run when this component is installed -->
    <postInstallationActionList>
        <actionList>...</actionList>
    </postInstallationActionList>
</component>
```

## Component Properties Explained

### Basic Properties

| Property | Values | Description |
|----------|--------|-------------|
| `name` | String | Unique identifier (no spaces) |
| `description` | String | Text shown in Custom Setup wizard |
| `canBeEdited` | 0 or 1 | 0 = Required (grayed out)<br>1 = Optional (can be unchecked) |
| `selected` | 0 or 1 | 0 = Unchecked by default<br>1 = Checked by default |
| `show` | 0 or 1 | 0 = Hidden from user<br>1 = Visible in list |
| `size` | Number | Size in KB (optional, auto-calculated if omitted) |

### Folder Properties

| Property | Values | Description |
|----------|--------|-------------|
| `description` | String | Description of this folder |
| `destination` | Path | Where files will be installed |
| `name` | String | Unique folder identifier |
| `platforms` | Platform list | `all`, `windows`, `linux`, `linux-x64` |
| `origin` | Path | Source directory containing files to copy |

## Current Components

### 1. Main Application (Required)
```xml
<component>
    <name>main</name>
    <description>${MAIN_COMPONENT_DESCRIPTION}</description>
    <canBeEdited>0</canBeEdited>  <!-- Cannot be deselected -->
    <selected>1</selected>
    <show>1</show>
    <!-- Contains program files, shortcuts, etc. -->
</component>
```

### 2. Documentation (Optional)
```xml
<component>
    <name>documentation</name>
    <description>${DOCS_COMPONENT_DESCRIPTION}</description>
    <canBeEdited>1</canBeEdited>  <!-- Can be deselected -->
    <selected>1</selected>
    <show>1</show>
    <!-- Contains documentation files -->
</component>
```

## Example: Adding New Components

### Example 1: SDK/Developer Tools Component

Add this component for development files:

```xml
<component>
    <name>sdk</name>
    <description>SDK and Development Tools</description>
    <canBeEdited>1</canBeEdited>
    <selected>0</selected>  <!-- Unchecked by default -->
    <show>1</show>

    <folderList>
        <!-- Header Files -->
        <folder>
            <description>Header Files</description>
            <destination>${installdir}/include</destination>
            <name>headers</name>
            <platforms>all</platforms>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/sdk/include</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>

        <!-- Library Files (Windows) -->
        <folder>
            <description>Library Files</description>
            <destination>${installdir}/lib</destination>
            <name>libraries_windows</name>
            <platforms>windows</platforms>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/sdk/lib/windows</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>

        <!-- Library Files (Linux) -->
        <folder>
            <description>Library Files</description>
            <destination>${installdir}/lib</destination>
            <name>libraries_linux</name>
            <platforms>linux linux-x64</platforms>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/sdk/lib/linux</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>

        <!-- Examples -->
        <folder>
            <description>SDK Examples</description>
            <destination>${installdir}/examples</destination>
            <name>examples</name>
            <platforms>all</platforms>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/sdk/examples</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
    </folderList>
</component>
```

### Example 2: Sample Data Component

```xml
<component>
    <name>samples</name>
    <description>Sample Data and Test Files</description>
    <canBeEdited>1</canBeEdited>
    <selected>1</selected>  <!-- Checked by default -->
    <show>1</show>

    <folderList>
        <folder>
            <description>Sample Files</description>
            <destination>${installdir}/samples</destination>
            <name>sampledata</name>
            <platforms>all</platforms>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/samples</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
    </folderList>
</component>
```

### Example 3: Language Pack Component

```xml
<component>
    <name>language_pack</name>
    <description>Additional Language Support</description>
    <canBeEdited>1</canBeEdited>
    <selected>0</selected>  <!-- Unchecked by default -->
    <show>1</show>

    <folderList>
        <!-- French Language -->
        <folder>
            <description>French Language Files</description>
            <destination>${installdir}/languages</destination>
            <name>lang_french</name>
            <platforms>all</platforms>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/languages/fr</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>

        <!-- German Language -->
        <folder>
            <description>German Language Files</description>
            <destination>${installdir}/languages</destination>
            <name>lang_german</name>
            <platforms>all</platforms>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/languages/de</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
    </folderList>
</component>
```

### Example 4: Plugins/Extensions Component

```xml
<component>
    <name>plugins</name>
    <description>Additional Plugins and Extensions</description>
    <canBeEdited>1</canBeEdited>
    <selected>1</selected>
    <show>1</show>

    <folderList>
        <folder>
            <description>Plugin Files</description>
            <destination>${installdir}/plugins</destination>
            <name>plugin_files</name>
            <platforms>all</platforms>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/plugins</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
    </folderList>

    <!-- Post-installation action for plugins -->
    <postInstallationActionList>
        <showInfo>
            <text>Plugins have been installed to:
${installdir}/plugins

Please restart the application to load the new plugins.</text>
            <title>Plugins Installed</title>
        </showInfo>
    </postInstallationActionList>
</component>
```

### Example 5: Desktop Integration Component

```xml
<component>
    <name>desktop_integration</name>
    <description>Enhanced Desktop Integration</description>
    <canBeEdited>1</canBeEdited>
    <selected>1</selected>
    <show>1</show>

    <folderList>
        <folder>
            <description>Integration Files</description>
            <destination>${installdir}/integration</destination>
            <name>integration_files</name>
            <platforms>windows</platforms>
            <distributionFileList>
                <distributionDirectory>
                    <origin>${SOURCE_DIR}/integration</origin>
                </distributionDirectory>
            </distributionFileList>
        </folder>
    </folderList>

    <!-- Windows-specific actions -->
    <postInstallationActionList>
        <actionGroup>
            <actionList>
                <!-- Register file associations -->
                <registrySet>
                    <key>HKEY_CLASSES_ROOT\.myext</key>
                    <name></name>
                    <value>MyApp.Document</value>
                    <type>REG_SZ</type>
                </registrySet>
                <registrySet>
                    <key>HKEY_CLASSES_ROOT\MyApp.Document</key>
                    <name></name>
                    <value>MyApp Document</value>
                    <type>REG_SZ</type>
                </registrySet>
                <registrySet>
                    <key>HKEY_CLASSES_ROOT\MyApp.Document\DefaultIcon</key>
                    <name></name>
                    <value>${installdir}\${WINDOWS_ICON}</value>
                    <type>REG_SZ</type>
                </registrySet>
            </actionList>
            <ruleList>
                <platformTest>
                    <type>windows</type>
                </platformTest>
            </ruleList>
        </actionGroup>
    </postInstallationActionList>
</component>
```

## Adding Variables for Components

When you add new components, add their descriptions to [variables.xml](variables.xml):

```xml
<!-- Component Descriptions -->
<MAIN_COMPONENT_DESCRIPTION>Main application files (required)</MAIN_COMPONENT_DESCRIPTION>
<DOCS_COMPONENT_DESCRIPTION>Documentation and user guides (optional)</DOCS_COMPONENT_DESCRIPTION>
<SDK_COMPONENT_DESCRIPTION>SDK and development tools for developers</SDK_COMPONENT_DESCRIPTION>
<SAMPLES_COMPONENT_DESCRIPTION>Sample data and test files</SAMPLES_COMPONENT_DESCRIPTION>
<LANGUAGE_COMPONENT_DESCRIPTION>Additional language support</LANGUAGE_COMPONENT_DESCRIPTION>
<PLUGINS_COMPONENT_DESCRIPTION>Additional plugins and extensions</PLUGINS_COMPONENT_DESCRIPTION>
```

## Where to Add Components

Add new components in [installer-template.xml](installer-template.xml) within the `<componentList>` section (after line 188, before line 211):

```xml
<componentList>
    <!-- Main Application Component -->
    <component>
        <name>main</name>
        ...
    </component>

    <!-- Optional Documentation Component -->
    <component>
        <name>documentation</name>
        ...
    </component>

    <!-- ADD YOUR NEW COMPONENTS HERE -->
    <component>
        <name>sdk</name>
        ...
    </component>

    <component>
        <name>samples</name>
        ...
    </component>

</componentList>
```

## Component Dependencies

You can make components depend on others using rules:

```xml
<component>
    <name>advanced_features</name>
    <description>Advanced Features</description>
    <canBeEdited>1</canBeEdited>
    <selected>0</selected>
    <show>1</show>

    <!-- Only show if SDK component is selected -->
    <shouldPackRuleList>
        <componentTest>
            <logic>selected</logic>
            <name>sdk</name>
        </componentTest>
    </shouldPackRuleList>

    <folderList>
        ...
    </folderList>
</component>
```

## Testing Component Selections

When users run your installer and reach the "Custom Setup" page, they will see:

```
Custom Setup
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Select the features you want to install:

☑ Main Application                    [Required - Cannot uncheck]
☑ Documentation                        [Can uncheck]
☐ SDK and Development Tools           [Can check/uncheck]
☑ Sample Data and Test Files          [Can check/uncheck]
☐ Additional Language Support         [Can check/uncheck]
☑ Additional Plugins                   [Can check/uncheck]

Feature Description:
[Shows description of selected component]

Install to: C:\Program Files\Keysight\MyApp\1.0.0
[Change...] [Space] [Help]

[Back] [Next] [Cancel]
```

## Tips

1. **Required vs Optional**:
   - Use `canBeEdited="0"` for components users must install
   - Use `canBeEdited="1"` for optional components

2. **Default Selection**:
   - `selected="1"` for commonly needed features
   - `selected="0"` for specialized features (SDK, language packs, etc.)

3. **Size Matters**:
   - Large optional components should default to unchecked
   - Let InstallBuilder auto-calculate sizes (don't specify `<size>`)

4. **Platform-Specific**:
   - Use `<platforms>` in folders for platform-specific files
   - Use `<ruleList>` with `<platformTest>` for platform-specific actions

5. **Clear Descriptions**:
   - Write clear, concise descriptions (shown in Custom Setup)
   - Users should understand what each component does

6. **Organization**:
   - Put related files in the same component
   - Don't create too many components (5-8 is usually enough)

## Modifying Existing Components

To modify the existing components, edit [installer-template.xml](installer-template.xml):

### Change Main Component Description
Edit line 33 and corresponding variable in [variables.xml](variables.xml).

### Add Files to Existing Component
Add a new `<folder>` within the component's `<folderList>`.

### Make Component Optional
Change `<canBeEdited>0</canBeEdited>` to `<canBeEdited>1</canBeEdited>`.

### Change Default Selection
Change `<selected>1</selected>` to `<selected>0</selected>`.

## Summary

Components allow users to customize their installation. Each component:
- Has a unique name and description
- Can be required or optional
- Can be selected or unselected by default
- Contains files, folders, shortcuts, and actions
- Can be platform-specific
- Can have dependencies on other components

Start simple with a few key components, then add more as needed!
