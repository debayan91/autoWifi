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

## Menu Bar Utility (Background)

The menu bar utility provides a "WiFi" icon in your system menu bar for manual triggers and status notifications.

### 1. Install Dependencies

Ensure Python 3 and `rumps` are installed:

```bash
pip install rumps
```

### 2. Install the Menu Bar App

Run the dedicated installation script:

```bash
chmod +x install_menubar.sh
./install_menubar.sh
```

This will:
- Mark `menubar.py` as executable.
- Set up a macOS LaunchAgent to start the app automatically at login.
- Start the app immediately.

### 3. Uninstall Menu Bar Utility

To remove the menu bar app and its auto-start configuration:

```bash
chmod +x uninstall_menubar.sh
./uninstall_menubar.sh
```

## How it works

The script periodically sends an authentication request to the network login endpoint.
If your network session expires or you reconnect to Wi-Fi, autoWifi automatically re-authenticates.

---

## Uninstall

To remove the service:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

This will stop the LaunchAgent and remove it from your system.

---

## Project Structure

```text
autoWifi
│
├── autowifi.sh        # login script
├── menubar.py         # macOS menu bar app
├── install.sh         # installs LaunchAgent (script-only)
├── install_menubar.sh # installs LaunchAgent (menu bar app)
├── uninstall.sh       # removes LaunchAgent (script-only)
├── uninstall_menubar.sh # removes LaunchAgent (menu bar app)
├── autowifi.plist     # macOS background service configuration
├── com.autowifi.menubar.plist # menu bar app LaunchAgent template
├── .gitignore
└── README.md
```

---

## Disclaimer

This project is intended for **personal automation on networks where you are authorized to authenticate**.
Ensure that using automated login complies with the policies of your network provider.
