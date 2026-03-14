import os
import subprocess
import rumps

class AutoWifiApp(rumps.App):
    def __init__(self):
        super(AutoWifiApp, self).__init__("WiFi")

    @rumps.clicked("Login WiFi")
    def login_wifi(self, _):
        # Resolve script path relative to the repo directory
        repo_dir = os.path.dirname(os.path.abspath(__file__))
        script_path = os.path.join(repo_dir, "autowifi.sh")
        
        try:
            # Execute ./autowifi.sh using subprocess
            subprocess.run([script_path], cwd=repo_dir, check=True)
            rumps.notification(
                "autoWifi",
                "Success",
                "Login script executed successfully."
            )
        except subprocess.CalledProcessError as e:
            rumps.notification(
                "autoWifi",
                "Error",
                f"Script failed with exit code {e.returncode}"
            )
        except Exception as e:
            rumps.notification(
                "autoWifi",
                "Error",
                f"Failed to run script: {e}"
            )

if __name__ == "__main__":
    app = AutoWifiApp()
    app.run()
