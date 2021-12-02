import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'MyApp.dart';

class IntroScreen extends StatelessWidget {
  static String id = 'IntroScreen';
  final List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      title: "Title of first page",
      body:
      "Here you can write the description of the page, to explain someting...",
      image:
      Center(child: Image.asset("images/sweephelper.png", height: 175.0)),
      decoration: const PageDecoration(
        pageColor: Colors.blue,
      ),
    ),
    PageViewModel(
      title: "Title of second page",
      body:
      "Here you can write the description of the page, to explain someting...",
      image:
      Center(child: Image.asset("images/sweepstat.png", height: 175.0)),
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