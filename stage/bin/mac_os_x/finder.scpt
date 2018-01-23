#!/usr/bin/osascript

-- When clicking on the icon
try
	tell application "Finder"
		set currentPath to (POSIX path of (target of front window as alias))
		set the clipboard to currentPath
	end tell
on error
	my finderErrorMsg()
end try

-- When dropping a folder onto the icon
on open {droppedFolder}
	try
		tell application "Finder"
			set currentPath to (POSIX path of droppedFolder as text)
			set the clipboard to currentPath
		end tell
	on error
		my finderErrorMsg
	end try
end open

-- Error msg when unable to copy a path to the clipboard
on finderErrorMsg()
	display dialog "Unable to copy a path to the clipboard. Make sure Finder is referencing a directory/folder within the file system." buttons {"Ok"} with icon caution with title "Error"
end finderErrorMsg

tell application "Finder"
	set currentPath to (POSIX path of (target of front window as text))
	set the clipboard to currentPath
	display dialog currentPath buttons {"ok"}
end tell