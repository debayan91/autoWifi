import rumps
from AppKit import NSWorkspace, NSWorkspaceDidWakeNotification
from PyObjCTools import AppHelper

class AutoWifiApp(rumps.App):
    def __init__(self):
        super(AutoWifiApp, self).__init__("WiFi")

    @rumps.clicked("Login WiFi")
    def login_wifi(self, _=None):
        # Resolve script path
        repo_dir = os.path.dirname(os.path.abspath(__file__))
        script_path = os.path.join(repo_dir, "autowifi.sh")
        try:
            subprocess.run([script_path], cwd=repo_dir, check=True)
            rumps.notification("autoWifi", "Success", "Login script executed successfully.")
        except Exception as e:
            rumps.notification("autoWifi", "Error", f"Failed to run script: {e}")

    def on_wake(self, _):
        self.login_wifi()

if __name__ == "__main__":
    app = AutoWifiApp()
    # Register for wake notification
    NSWorkspace.sharedWorkspace().notificationCenter().addObserver_selector_name_object_(
        app, "on_wake", NSWorkspaceDidWakeNotification, None
    )
    app.run()
