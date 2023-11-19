# flutter_calculator

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# 19 Nov 2023

https://docs.flutter.dev/get-started/install/linux

I downloaded the flutter_linux_3.16.0-stable.tar.xz

extracted it to HOME directory and then executed

```bash
export PATH="$PATH:$HOME/flutter/bin"
flutter doctor
```

Add the line 1 to your bashrc to make it permanent.


I then installed JDK (openjdk)

```bash
sudo apt install default-jdk
```


I then installed Android Studio from snap

```bash
sudo snap install android-studio --classic
```



I then installed clang, cmake, gtk3 as in my flutter doctor command they showed missing.

```bash
sudo apt install clang cmake libgtk-3-dev
```


Then I executed this line to connect chrome to flutter. Add this line to your bashrc to make it permanent.

```bash
export CHROME_EXECUTABLE=/opt/google/chrome/google-chrome 
```
