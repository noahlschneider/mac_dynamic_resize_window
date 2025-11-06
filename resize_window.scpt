use framework "AppKit"
use scripting additions

-- Configuration parameters
set wPercentage to 0.5
set hPercentage to 0.7

-- Initialize log string
set logStr to ""

-- Get the front most window position & size, including calculating position of bottom right corner of window
tell application "System Events"
	set currentApplication to (first application process whose frontmost is true)
	set applicationName to name of currentApplication
	tell currentApplication
		-- Throw error if application doesn't have a window
		if not (exists of window 1) then
			error "Cannot find window for " & applicationName number 1001
		end if
		set currentWindow to window 1
		tell currentWindow
			set {windowX, windowY} to position
			set {windowW, windowH} to size
			set {windowX, windowY} to {(windowX + windowW), (windowY + windowH)}
		end tell
	end tell
end tell

-- Get the list of displays
set displayList to current application's NSScreen's screens()

-- Throw error if there are not 1 or 2 displays connected
set displayCount to count of displayList
if (displayCount ≠ 1 and displayCount ≠ 2) then
	error "Only 1 or 2 displays supported" number 1001
end if

-- Iterate over displays getting position & size, seperating primary & secondary displays
set primaryX to missing value
repeat with display in displayList
	set frame to display's frame()
	set {framePosition, frameSize} to frame
	set {x, y} to framePosition
	set {w, h} to frameSize
	set visibleFrame to display's visibleFrame()
	set {visibleFramePosition, visibleFrameSize} to visibleFrame
	set {visibleX, visibleY} to visibleFramePosition
	set {visibleW, visibleH} to visibleFrameSize
	if x = 0 then
		set {primaryX, primaryY, primaryW, primaryH} to {x, y, w, h}
		set {primaryVisibleX, primaryVisibleY, primaryVisibleW, primaryVisibleH} to {visibleX, visibleY, visibleW, visibleH}
	else
		set {secondaryX, secondaryY, secondaryW, secondaryH} to {x, y, w, h}
		set {secondaryVisibleX, secondaryVisibleY, secondaryVisibleW, secondaryVisibleH} to {visibleX, visibleY, visibleW, visibleH}
	end if
end repeat

-- Throw error if primary display not calculated
if primaryX is missing value then
	error "Primary display not correctly detected" number 1002
end if

-- Set display and position based on which display window is on
if displayCount = 1 then
	set secondaryOffset to 0
	set windowOn to "primary"
	set {x, y, w, h} to {primaryX, primaryY, primaryW, primaryH}
	set {visibleX, visibleY, visibleW, visibleH} to {primaryVisibleX, primaryVisibleY, primaryVisibleW, primaryVisibleH}
else
	set secondaryYOffset to (secondaryH - primaryH)
	if (windowX > primaryX and windowX ≤ (primaryX + primaryW)) then
		set windowOn to "primary"
		set {x, y, w, h} to {primaryX, primaryY, primaryW, primaryH}
		set {visibleX, visibleY, visibleW, visibleH} to {primaryVisibleX, primaryVisibleY, primaryVisibleW, primaryVisibleH}
		set windowY to windowY + secondaryYOffset
	else
		set windowOn to "secondary"
		set {x, y, w, h} to {secondaryX, secondaryY, secondaryW, secondaryH}
		set {visibleX, visibleY, visibleW, visibleH} to {secondaryVisibleX, secondaryVisibleY, secondaryVisibleW, secondaryVisibleH}
	end if
end if

-- Calculate new window size & position
set newW to visibleW * wPercentage
set newH to visibleH * hPercentage
set xTopSpace to (visibleW - newW) / 2
set newX to x + xTopSpace
set menuBarHeight to (h - visibleH - visibleY)
set secondaryOffsetY to (primaryH - h)
set yTopSpace to (visibleH - newH) / 2
set newY to menuBarHeight + yTopSpace + secondaryOffsetY

-- Apply new window size & position (twice to ensure correct)
tell application "System Events"
	tell currentApplication
		tell currentWindow
			set size to {newW, newH}
			set position to {newX, newY}
			delay 0.1
			set size to {newW, newH}
			set position to {newX, newY}
		end tell
	end tell
end tell

-- Optional: Debugging
set logStr to logStr & "Primary display bounds {total, visible}: {" & primaryX & ", " & primaryY & ", " & primaryW & ", " & primaryH & "}, {" & primaryVisibleX & ", " & primaryVisibleY & ", " & primaryVisibleW & ", " & primaryVisibleH & "}" & return
if displayCount = 2 then
	set logStr to logStr & "Secondary display bounds {total, visible}: {" & secondaryX & ", " & secondaryY & ", " & secondaryW & ", " & secondaryH & "}, {" & secondaryVisibleX & ", " & secondaryVisibleY & ", " & secondaryVisibleW & ", " & secondaryVisibleH & "}" & return
	set logStr to logStr & "Secondary display offset: " & secondaryYOffset & return
end if
set logStr to logStr & "Current display bounds {total, visible}: {" & x & ", " & y & ", " & w & ", " & h & "}, {" & visibleX & ", " & visibleY & ", " & visibleW & ", " & visibleH & "}" & return
set logStr to logStr & "Current window bottom right coordinate: {" & windowX & ", " & windowY & "}" & return
set logStr to logStr & "Window on: " & windowOn & " display" & return
set logStr to logStr & "New window size: {" & newW & ", " & newH & "}" & return
set logStr to logStr & "New window position: {" & newX & ", " & newY & "}" & return
do shell script "echo " & logStr