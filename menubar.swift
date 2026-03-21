import AppKit
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {
    let scriptPath = "/Users/debayan/Documents/projects/autoWifi/autowifi.sh"
    var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(_ n: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem.button {
            button.title = "autoWifi"
        }

        let menu = NSMenu()

        let runItem = NSMenuItem(
            title: "Run Script",
            action: #selector(runScript),
            keyEquivalent: "r"
        )
        runItem.target = self

        let quitItem = NSMenuItem(
            title: "Quit",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q"
        )

        menu.addItem(runItem)
        menu.addItem(.separator())
        menu.addItem(quitItem)

        statusItem.menu = menu
    }

    @objc func runScript() {
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = [scriptPath]
        try? task.run()
    }
}

let app = NSApplication.shared
app.setActivationPolicy(.accessory)
let delegate = AppDelegate()
app.delegate = delegate
app.run()
