# Overview

This project lets you **dynamically resize & center Mac windows to a chosen proportion of your screen**, adapting automatically to any display size. I use it to neatly center windows on my ultrawide monitor.

This implementation uses:
- **Apple Script** for the core script.
- **Automator** to make the script a quick action.
- **System Settings**'s keyboard shortcuts to enable quick access.

# Limitations
- **1 or 2 displays only** - at this time, the project only supports 1 or 2 monitors. I may add this functionality later, but my setup is only ever 2 monitors.
- **Second display must be bottom right aligned** - at this time, the project only works when the secondary monitor is bottom right aligned.
  - This can be configured in System Settings. Select "Displays" then arrange, & make sure the secondary monitor is aligned to the bottom right of the primary display, with the bottom edge aligned with the primary display's bottom edge, as seen below.
  ![plot](display_arrangement.png)

# Configuration
There are 2 configuration parameters. Both are decimal numbers between 0 & 1.
1. **`wPercentage`** - desired percentage of the display width the window will take up. Default: `0.65`.
2. **`hPercentage`** - desired percentage of the display height the window will take up. Default: `0.5`.

# Setup

## Configure Automator Quick Action
1. If you want to change the `wPercentage` or `hPercentage` from defaults, right click `center_wide_resize.workflow` & select open with Automator (not Automator Installer). Change the parameters to the desired values. Save the document. Note this will install the quick action, so you can skip "Install Automator Quick Action".
2. If you want change the name from the default ("Center Focus Resize") & "Save As" (⌥⇧⌘S), renaming with the desired name.

### Notes
- Either of the above configurations will install the quick action, so you can skip the "Install Automator Quick Action" section.
- If you want multiple shortcuts, you can edit the script again with different configurations. Just make sure to "Save As" again with a new name rather than overwriting your existing file.

## Install Automator Quick Action
To install the script with the default values Double click `center_wide_resize.workflow` to open with Automator Installer. Click install.

## Add Keyboard Shortcuts
Open System Settings. Select "Keyboard" then "Keyboard Shortcuts..." then "Services". Expand "General" & find the quick action you created. Click on "none" & enter the desired keyboard shortcut. I use ⌃⌥ + a number key for multiple different resize shortcuts.

## Add Accessibility Permissions for WorflowServiceRunner
Go to "System Settings" then "Privacy & Security" & select "Accessibility". You will need to add WorkflowServiceRunner by clicking the `+` button, then ⇧⌘g to bring up the file path dialog. Enter the path `/System/Library/Frameworks/AppKit.framework/Versions/C/XPCServices/WorkflowServiceRunner.xpc/Contents/MacOS/WorkflowServiceRunner` then return. Ensure the toggle is turned on.

While you're here, you can also add all the apps you desire to control using the quick action to avoid having to do it in the "Trigger the Command & Enable Permissions for Each App" section.

## Trigger the Command & Enable Permissions for Each App
1. For security purposes, MacOS requires you to add permissions for the quick action to run for each app. Trigger your keyboard shortcut & you should get the following:

    `"[Your App].app" wants access to control "System Events.app". Allowing control will provide access to documents & data in "System Events.app", & to perform actions within that app.`


   Click "Allow".
2. Additionally, you'll need to add accessibility permissions for each app. This comes up in a warning like:

    `"[Your App].app" would like to control this computer using accessibility feature. Grant access to this application in Privacy & Security Settings, located in System Settings`

    Click "Open System Settings" & turn the toggle on for your app.

    When this error pops up, you will also get the following error at the same time:

    `The action "Run AppleScript" encountered an error: "System Events got an error: Automator Workflow Runner (WorkflowServiceRunner, Center Half Resize) is not allowed assistive access."`

    This error can be ignored & will disappear after you give the app accessibility permissions.

## Confirm Shortcut Works
After enabling all permissions, trigger the keyboard shortcut again & ensure it runs successfully.

# Notes
- The code for the Apple Script the Automator action calls can be reviewed either in Automator by right clicking `center_wide_resize.workflow` & select open with Automator (not Automator Installer) or standalone in `resize_window.scpt` which is included for reference.
- Automator installs Quick Actions to `~/Library/Services/`. If you later need to delete the shortcuts, you can add them here.