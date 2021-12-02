import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'MyApp.dart';

class IntroScreen extends StatelessWidget {
  static String id = 'IntroScreen';
  final List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      title: "Welcome to the SweepStat App",
      body:
      "Here you are to use the App to start the experiment, analyze the data, and export the result.",
      image:
      Center(child: Image.asset("images/sweephelper.png", height: 175.0)),
      decoration: const PageDecoration(
        pageColor: Colors.blue,
      ),
    ),
    PageViewModel(
      title: "This is your SweepStat hardware.",
      body:
      "For source code and assembly instructions, please follow the SweepStat website.",
      image:
      Center(child: Image.asset("images/sweepstat.png", height: 250.0)),
      decoration: const PageDecoration(
        pageColor: Colors.blue,
      ),
    ),
    PageViewModel(
      title: "BE CAREFUL BEFORE YOU USE!",
      body:
      "1. Open the bluetooth switch before you try to collect data. (Otherwise it will be only noises)\n2. Press the reset button whenever you don't know what happened.\n3. !!! Close the bluetooth switch to save your bluetooth battery.",
      image:
      Center(child: Image.asset("images/explain.png", height: 300.0)),
      decoration: const PageDecoration(
        pageColor: Colors.blue,
      ),
    )
  ];

  final Intro intro = Intro(
    noAnimation: false,
    stepCount: 6,
    maskClosable: true,
    onHighlightWidgetTap: (introStatus) {
      print(introStatus);
    },
    padding: EdgeInsets.all(8),
    borderRadius: BorderRadius.all(Radius.circular(4)),
    widgetBuilder: StepWidgetBuilder.useDefaultTheme(
      texts: [
        'Use this setting to configure your experiments.',
        'Click here to connect SweepStat Bluetooth.',
        'Start your experiment after configure the settings and connect to the bluetooth.',
        'Save your experiment result after the experiment.',
        'Share or Export your experiment result.',
        'Click here to see your saved configurations and experiments.',
      ],
      buttonTextBuilder: (curr, total) {
        return curr < total - 1 ? 'Next' : 'Finish';
      },
    ),
  );

  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: listPagesViewModel,
      onDone: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: "SweepStat", intro: intro)));
      },
      onSkip: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: "SweepStat", intro: intro)));
      },
      showSkipButton: true,
      skip: const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.navigate_next),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    );
  }
}