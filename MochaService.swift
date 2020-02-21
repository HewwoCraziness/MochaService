import Foundation

NSLog ("Service is running as user with ID %d", getuid ())

if Int (getuid ()) != 0 {
	NSLog ("%@", "Service was not run as root (id 0)! Exiting... make sure you're running with sudo.")
	exit (1)
}

// thanks https://stackoverflow.com/a/26973384/5037905
func shell(_ args: String...) {
	let task = Process ()
	task.launchPath = "/usr/bin/env"
	task.arguments = args
	task.launch ()
	task.waitUntilExit ()
}

let arguments = ProcessInfo.processInfo.arguments
if arguments.count == 2 {
	let action = ProcessInfo.processInfo.arguments [1]
	NSLog ("Action: %@", action)
	switch action {
		case "activate":
			NSLog ("%@", "Activating Mocha...")
			shell ("pmset", "-a", "disablesleep", "1")
			NSLog ("%@", "Finished.")
			break
		case "deactivate":
			NSLog ("%@", "Deactivating Mocha...")
			shell ("pmset", "-a", "disablesleep", "0")
			NSLog ("%@", "Finished.")
			break
		case "uninstall":
			NSLog ("%@", "Uninstalling is not implemented yet!")
			break
		default:
			NSLog ("%@", "Invalid action!")
			break
		
	}
} else {
	NSLog ("%@", "No action was specified. Valid actions are activate, deactivate, uninstall (not implemented yet).")
}
