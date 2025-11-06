# Overview

This project lets you **dynamically resize and center Mac windows to a chosen proportion of your screen**, adapting automatically to any display size. I use it to neatly center windows on my ultrawide monitor.

This implementation uses:
- **Apple Script** for the core script.
- **Automator** to make the script a quick action.
- **System Settings**'s keyboard shortcuts to enable quick access.

# Limitations
- **1 or 2 displays only** - at this time, the project only supports 1 or 2 monitors. I may add this functionality later, but my setup is only ever 2 monitors.
- **Second display must be bottom right aligned** - at this time, the project only works when the secondary monitor is bottom right aligned.
  - This can be configured in System Settings. Select "Displays" then arrange, and make sure the secondary monitor is aligned to the bottom right of the primary display, with the bottom edge aligned with the primary display's bottom edge, as seen below.
  ![plot](display_arrangement.png)

# Configuration
There are 2 configuration parameters. Both are decimal numbers between 0 and 1.
1. **`wPercentage`** - desired percentage of the display width the window will take up. Default: `0.65`.
2. **`hPercentage`** - desired percentage of the display height the window will take up. Default: `0.5`.

# Setup

## Configure Automator Quick Action
1. If you want to change the `wPercentage` or `hPercentage` from defaults, right click `center_wide_resize.workflow` and select open with Automator (not Automator Installer). Change the parameters to the desired values. Save the document. Note this will install the quick action, so you can skip "Install Automator Quick Action".
2. If you want change the name from the default ("Center Focus Resize") press ⌥⇧⌘S and renaming enter the desired name.

Note either of the above configurations will install the quick action, so you can skip "Install Automator Quick Action".

## Install Automator Quick Action
To install the script with the default values Double click `center_wide_resize.workflow` to open with Automator Installer. Click install.

## Add Keyboard Shortcuts
Open System Settings. Select "Keyboard" then "Keyboard Shortcuts..." then "Services". Expand "General" and find the quick action you created. Click on "none" and enter the desired keyboard shortcut. I use ⌃⌥1. 