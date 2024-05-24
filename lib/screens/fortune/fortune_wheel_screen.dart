import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shwetaiksan/screens/ads/rewarded_ads.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({Key? key}) : super(key: key);

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  late ConfettiController _controllerCenter;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerBottomCenter;
  final selected = BehaviorSubject<int>();
  int rewards = 0;
  RewardedAdManager rewardedAdManager = RewardedAdManager();
  List<int> items = [50, 100, 50, 200, 50, 500, 50, 1000, 50, 2000];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    rewardedAdManager.loadRewardAd();
    // Timer.periodic(const Duration(seconds: 15), (timer) {
    //
    // });
  }

  void playConfetti() {
    _controllerCenter.play();
  }

  @override
  void dispose() {
    selected.close();
    _controllerCenter.dispose();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerTopCenter.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spin Wheel"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality
                    .explosive, // don't specify a direction, blast randomly
                shouldLoop:
                    true, // start again as soon as the animation is finished
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
                createParticlePath: drawStar, // define a custom shape/path.
              ),
            ),
            Material(
              elevation: 20,
              color: Colors.orange,
              borderRadius: BorderRadius.circular(150),
              child: SizedBox(
                height: 300,
                width: 300,
                child: FortuneWheel(
                  styleStrategy: AlternatingStyleStrategy(),
                  selected: selected.stream,
                  animateFirst: false,
                  items: [
                    for (int i = 0; i < items.length; i++) ...<FortuneItem>{
                      FortuneItem(
                          style: FortuneItemStyle(
                              color: (i % 2 == 0)
                                  ? Colors.white.withOpacity(0.2)
                                  : Colors.blue),
                          child: Text(
                            items[i].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    (i % 2 != 0) ? Colors.white : Colors.black),
                          )),
                    },
                  ],
                  onAnimationStart: () {
                    rewardedAdManager.loadRewardAd();
                    setState(() {});
                  },
                  onAnimationEnd: () {
                    rewardedAdManager.showRewardAd();
                    setState(() {
                      rewards = items[selected.value];
                    });
                    print(rewards);
                    playConfetti();
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            desc: "ဂုဏ်ယူပါတယ် သင် $rewards ကျပ် ကံထူးပါသည်",
                            btnOkOnPress: () {})
                        .show();
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text(
                    //         "You just won " + rewards.toString() + " Points!"),
                    //   ),
                    // );
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selected.add(Fortune.randomInt(0, items.length));
                });
              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue, width: 3)),
                  child: Center(
                    child: Text("SPIN"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: AdWidget(
                ad: rewardedAdManager.getBannerAd()..load(),
                key: UniqueKey(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
