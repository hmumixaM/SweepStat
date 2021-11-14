# SweepStat
SweepStat is low-cost electrochemical equipment to make labs affordable. We are excited to work on the APP for SweepStat to collect, analyze, and share data on electrochemical equipment. The repository is the iOS and Android app to communicate with the SweepStat hardware. 


# Getting Started
This is a Flutter app. The Flutter and Dart SDKs/CLI tools can be installed with most any IDE, but Flutter/Dart have direct plugin support in IntelliJ IDEA/Android Studio and Visual Studio Code. Installing via the extension tools in these IDEs will add the relevant scripts to your PATH and configure things like pub, Flutter's package manager.

To build/debug our code, a simple git clone followed by "flutter pub get" in the app root directory will pull all of the source code and dependencies. The dependencies are configured in pubspec.yaml, which can be edited if you choose to extend our functionality or prefer different versions of those dependencies. To run locally, you can use the Flutter CLI (reference https://flutter.dev/docs/reference/flutter-cli). However, we prefer the automatic graphical tools offered by IDEA. The target menu will allow you to select a web browser, real device, or emulator (XCode is required for an iOS emulator), and the run button will execute the Flutter commands to start a reloadable version of the app on your device of choice. 

It is worth noting that for web or an emulator, the Bluetooth will not be functional and the local database storage may not be functional or need to be swapped to a supported location in file_manager.dart. For Android emulators, this means switching getDatabasesPath() to getExternalStorageDirectory().path. These instructions work as of 4pm on 11/14/2021 on a Windows 10 laptop running a Pixel 6 emulator in Android Studio.


# Testing
Testing our app is ridiculously simple. Just run "flutter test" in the app root directory. However, if you only want to test a portion of the app, you can specify a relative directory like "flutter test test/file_management". Our integration and E2E tests are stored in their own named-as-such folders.

# Deployment


# Technologies Used
Flutter libraries used

share: https://pub.dev/packages/share
path_provider: https://pub.dev/packages/path_provider
fl_chart: https://pub.dev/packages/fl_chart
flutter_blue: https://pub.dev/packages/flutter_blue
Development tools used

IntelliJ IDEA: https://www.jetbrains.com/idea/
Flutter: https://flutter.dev/
SweepStat potentiostat: https://www.nanoelectrochemistry.com/sweepstat
Android and iOS devices
ADRs can be found at: https://www.notion.so/uncch/Architecture-d3b9575eb00a4b078d073ec58aa73ecc#660cdc91261b4f8085bd534054108616

# Contributing
During the Fall 2021 semester(2021.08-12), this project is being developed by a team of students in the COMP 523: Software Engineering Laboratory class at UNC Chapel Hill. Requirements for future contributions are TBD by the SweepStat research team, and the readme will be updated accordingly. As of now, this repository is the only system the developers need access to in order to contribute to the project. 

This project is based on previous comp523 group's contribution: https://github.com/matthewverber/sweep_stat_app

Compare to the previous project, we restructure the code into different sections: analysis, bluetooth, drawer, end_drawer, experiment, filemanagement, guided_setip_pages, and screen. Each section contains all relative fils so should be easy to read. 

For code style, we mainly follow the official coding style provided by Google.

For more information, see our project site for the Fall 2021 semester:
https://uncch.notion.site/uncch/SweepStat-d0259ba917ad4c7a8bc5e508f663ac7d

# Authors

Yang Hu: yanghu@live.unc.edu
         https://github.com/hmumixaM
Matt Wasyluk: mwasyluk@unc.edu
              https://github.com/m-wasyluk
Yumeng Zhang: rainymz@live.unc.edu
              https://github.com/rainymz

# License


# Acknowledgements
We first need to thank our clients, Rebecca Clark and Matthew Verber of the SweepStat team for giving us the opportunity to work with them. We appreciate that they have kept their trust in us during the process of completing the project, taking the time to check our progress every week and giving us reasonable feedback. Always patient and positive replies when we have questions. For each of us, the experience of completing the SweepStat project has been unforgettable and rewarding.

Secondly, we would like to thank our mentor, Jonathan Camenisch, who also sacrificed his time off each week to help us. During the weekly mentor meetings, he kept track of our progress, addressed technical issues, went through our code and found out potential pitfalls, and gave constructive advice on our coursework and project management. On top of that, outside of the project, Jonathan, as an experienced programmer, gave us a lot of long-term advice on how to choose the right company for us and how to communicate and work with the rest of the team. We really appreciate his guidance and help.

Finally, we would also like to thank Dr. Jeff Terrell, professor of Comp523. We thank him for giving us the opportunity to not only practice our technical skills, but also to learn about teamwork and how to communicate with clients. This is not only a professional class of Comp department, but also a guidance class to help us enter the workplace.
