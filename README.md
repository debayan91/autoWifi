# autoWifi

autoWifi automatically logs into **captive portal Wi-Fi networks** on macOS.

Many networks require you to enter credentials in a login page every time you reconnect.
autoWifi automates this process so authentication happens silently in the background.

---

## Features

* Automatic login to captive portal Wi-Fi networks
* Runs in the background using macOS **LaunchAgents**
* No manual login required after setup
* Lightweight shell-based implementation

---

## Requirements

* macOS
* `curl` (included with macOS)
* Network credentials for your captive portal

---

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/debayan91/autoWifi.git
cd autoWifi
```

### 2. Add your credentials

Copy the `.env.example` file to create your local `.env` configuration:

```bash
cp .env.example .env
```

Open `.env` and fill in your credentials:

```bash
PROVIDER_URL=http://phc.prontonetworks.com/cgi-bin/authlogin
USER_ID=your_username
PASSWORD=your_password
```

---

### 3. Install the auto-login service

Run:

```bash
chmod +x install.sh
./install.sh
```

This will:

* make the login script executable
* install a macOS LaunchAgent
* start the background service

---

---

## Menu Bar Utility (Native Swift)

The menu bar utility provides a native macOS "autoWifi" icon in your system menu bar for manual triggers. It is built using Swift with zero third-party dependencies.

### 1. Requirements

* macOS Command Line Tools (for `swiftc`)

```bash
xcode-select --install
```

### 2. Compile & Install

The utility consists of a single Swift file `menubar.swift`. You can compile it and set it to start automatically at login:

**Compile the App:**

```bash
swiftc -framework AppKit menubar.swift -o MenuBarApp
```

**Set up Auto-start (LaunchAgent):**

1. Create a directory for LaunchAgents if it doesn't exist:

   ```bash
   mkdir -p ~/Library/LaunchAgents
   ```

2. Copy the provided `.plist` to your LaunchAgents folder (ensure you update the path to the `MenuBarApp` binary within the plist):

   ```bash
   cp com.debayan.menubarapp.plist ~/Library/LaunchAgents/
   ```

3. Load the service:

   ```bash
   launchctl load ~/Library/LaunchAgents/com.debayan.menubarapp.plist
   ```

### 3. Usage

* You will see `autoWifi` in your menu bar.
* Click **"Run Script"** (or use `Cmd+R`) to manually trigger the `autowifi.sh` script.
* Click **"Quit"** (or use `Cmd+Q`) to exit the application.

### 4. Uninstall

To remove the menu bar app and its auto-start configuration:

```bash
launchctl unload ~/Library/LaunchAgents/com.debayan.menubarapp.plist
rm ~/Library/LaunchAgents/com.debayan.menubarapp.plist
rm MenuBarApp
```

## How it works

The `autowifi.sh` script handles the `curl`-based authentication. The Swift menu bar app acts as a wrapper that allows you to trigger this script easily from the GUI without keeping a terminal open.

---

## Uninstall Service

To remove the core background service (script-only):

```bash
chmod +x uninstall.sh
./uninstall.sh
```

---

## Project Structure

```text
autoWifi
│
├── autowifi.sh                # Core login script
├── menubar.swift             # Native Swift menu bar app source
├── MenuBarApp                # Compiled binary (after build)
├── install.sh                # Installs LaunchAgent (script-only)
├── uninstall.sh              # Removes LaunchAgent (script-only)
├── autowifi.plist            # macOS background service configuration
├── com.debayan.menubarapp.plist # Menu bar app LaunchAgent configuration
├── .gitignore
└── README.md
```

---

## Disclaimer

This project is intended for **personal automation on networks where you are authorized to authenticate**.
Ensure that using automated login complies with the policies of your network provider.
