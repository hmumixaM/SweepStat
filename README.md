# SweepStat
SweepStat is low-cost electrochemical equipment to make labs affordable. We are excited to work on the APP for SweepStat to collect, analyze, and share data on electrochemical equipment. The repository is the iOS and Android app to communicate with the SweepStat hardware. 


# Getting Started
This is a Flutter app. The Flutter and Dart SDKs/CLI tools can be installed with most any IDE, but Flutter/Dart have direct plugin support in IntelliJ IDEA/Android Studio and Visual Studio Code. Installing via the extension tools in these IDEs will add the relevant scripts to your PATH and configure things like pub, Flutter's package manager.

To build/debug our code, a simple git clone followed by "flutter pub get" in the app root directory will pull all of the source code and dependencies. The dependencies are configured in pubspec.yaml, which can be edited if you choose to extend our functionality or prefer different versions of those dependencies. To run locally, you can use the Flutter CLI (reference https://flutter.dev/docs/reference/flutter-cli). However, we prefer the automatic graphical tools offered by IDEA. The target menu will allow you to select a web browser, real device, or emulator (XCode is required for an iOS emulator), and the run button will execute the Flutter commands to start a reloadable version of the app on your device of choice. 

It is worth noting that for web or an emulator, the Bluetooth will not be functional and the local database storage may not be functional or need to be swapped to a supported location in file_manager.dart. For Android emulators, this means switching getDatabasesPath() to getExternalStorageDirectory().path. These instructions work as of 4pm on 11/14/2021 on a Windows 10 laptop running a Pixel 6 emulator in Android Studio.


# Testing
Testing our app is ridiculously simple. Just run "flutter test" in the app root directory. However, if you only want to test a portion of the app, you can specify a relative directory like "flutter test test/file_management". Our integration and E2E tests are stored in their own named-as-such folders.
