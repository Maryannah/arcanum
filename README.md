# Commands

```bash
npm run                     # Provides a list of runnable commands

# Utils
npm run game:script         # Downloads and prettifies the game script for dev purposes

# APK management
npm run android:debug        # Creates a debuggable.apk in the static folder
npm run android:bash         # For playing with android tools
npm run android:pair         # Script to connect to a device with ADB
```

# APK tips & tricks

## Create a debuggable APK

- Download the APK (e.g. https://apkpure.com/fr/)
- Paste the APK to `static/apks/game.apk`

The created APK can be installed on a phone and remotely connected to

# Process to install the scripts into the game

- Run the proxy `npm run proxy:serve`
- Run the api `npm run api:serve`
- Set the proxy on the phone
- Go to http://mitm.it/ : it should show help (if not, proxy not working)
- Install the certificate on the device by following the help
- Install the game while under proxy
- Once the game is installed, proxy becomes useless and can be stopped