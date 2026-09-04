# Flutter + Android Setup on Linux (command-line only)

This is a from-scratch, terminal-only path to get Flutter running on Ubuntu
Linux, written up from an actual first-time setup session — including the
snags that came up and how they were resolved.

You do **not** need to install Android Studio's GUI for any of this — the
Android SDK command-line tools are enough.

## 1. Install the Flutter SDK

```bash
git clone https://github.com/flutter/flutter.git -b stable ~/development/flutter
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
flutter --version
```

## 2. Install Java (required by Android tooling)

```bash
sudo apt update
sudo apt install -y openjdk-17-jdk
java -version
```

> If `apt install` fails with unmet dependencies unrelated to Java (e.g. an
> unrelated broken package), run `sudo apt --fix-broken install` first,
> then retry the Java install.

## 3. Install the Android command-line tools

```bash
mkdir -p ~/Android/Sdk/cmdline-tools
cd ~/Android/Sdk/cmdline-tools
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
unzip commandlinetools-linux-11076708_latest.zip
mv cmdline-tools latest
```

The folder must be named exactly `latest` inside `cmdline-tools`, or
`sdkmanager` won't find it. Check the
[official download page](https://developer.android.com/studio#command-line-tools-only)
for the current zip filename if this one is outdated.

## 4. Set environment variables

Add to the end of `~/.bashrc`:

```bash
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator
```

Then:

```bash
source ~/.bashrc
```

## 5. Install SDK packages

```bash
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0" "emulator" "system-images;android-34;google_apis;x86_64"
```

Accept the license prompt(s) with `y`.

## 6. Accept all Android licenses

```bash
flutter doctor --android-licenses
```

Type `y` for every prompt (there are 5–7).

## 7. Verify

```bash
flutter doctor
```

You want green checkmarks on **Flutter** and **Android toolchain**. Chrome
and Linux desktop toolchain warnings are irrelevant if you're only targeting
Android — ignore them.

> **Note:** on first check, `flutter doctor` may report a required SDK
> version/build-tools mismatch (e.g. "Flutter requires Android SDK 36 and
> Build-Tools 28.0.3"). If so, install the versions it names:
> ```bash
> sdkmanager "platforms;android-36" "build-tools;28.0.3"
> ```
> then re-run `flutter doctor` to confirm it clears.

## 8. Running on an emulator vs. a real device

### Option A: Emulator

```bash
avdmanager create avd -n pixel6 -k "system-images;android-34;google_apis;x86_64" -d pixel_6
emulator -avd pixel6
```

**Known issue:** the emulator requires hardware virtualization (KVM). If you
see:

```
ERROR | x86_64 emulation currently requires hardware acceleration!
CPU acceleration status: /dev/kvm is not found: VT disabled in BIOS or KVM kernel module not loaded
```

Check whether your CPU/BIOS supports it:

```bash
sudo kvm-ok
egrep -c '(vmx|svm)' /proc/cpuinfo
```

If this returns `0`/"cannot be used", virtualization is disabled in your
BIOS/UEFI (or, rarely, genuinely unsupported by the CPU or blocked by the
manufacturer). To try enabling it: reboot, enter BIOS setup (commonly `F10`
or `F2` at boot on HP laptops), find **Virtualization Technology / Intel
VT-x**, enable it, save and exit. Some consumer laptops hide or lock this
option entirely — if you can't find it after a reasonable look, don't
spend too long chasing it; use Option B instead.

### Option B: Real Android device (recommended if the emulator fights you)

This sidesteps the virtualization requirement entirely and is often faster
to get working on an unfamiliar machine:

1. On the phone: **Settings → About phone → Software info → tap "Build
   number" 7 times** to unlock Developer Options. (The exact menu path
   varies by phone brand — look under "About phone" first, then
   "Software info" or "Status info" if Build number isn't directly visible.)
2. **Settings → Developer options → enable USB debugging**
3. Connect via USB, tap **Allow** on the "Allow USB debugging?" popup that
   appears on the phone
4. Verify from the laptop:
   ```bash
   adb devices
   ```
   Should list your device as `device` (not `unauthorized` or empty).

   If it shows nothing:
   ```bash
   adb kill-server
   adb start-server
   adb devices
   ```
   Also try unplugging/replugging the cable, and confirm it's a data cable
   (not charge-only).

## 9. Generate platform folders and run

If the Flutter project was created by hand rather than via `flutter create`
(as this one was, since it was written without a local Flutter SDK to run
that command against), the `android/`, `ios/`, `linux/` etc. folders won't
exist yet. Generate them without touching existing code:

```bash
cd ghore_khai
flutter create .
```

Then:

```bash
flutter devices     # confirm your device/emulator is listed
flutter run -d android   # explicitly target Android if multiple devices are listed
```

First build takes a few minutes (Gradle dependencies + compilation). After
that, press `r` in the terminal running `flutter run` for hot reload.
