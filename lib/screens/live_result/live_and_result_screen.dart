import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shwetaiksan/constants/color_const.dart';
import 'package:shwetaiksan/provider/live_result_provider.dart';

import '../ads/rewarded_ads.dart';

class LiveAndResultScreen extends StatelessWidget {
  const LiveAndResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RewardedAdManager rewardedAdManager = RewardedAdManager();
    return ChangeNotifierProvider<LiveAndResultProvider>(
      create: (context) => LiveAndResultProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("2D တိုက်ရိုက်"),
        ),
        body: Consumer<LiveAndResultProvider>(
          builder: (context, data, _) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlinkText(data.liveData?.twod ?? "--",
                      style: const TextStyle(
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(5.0, 5.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                          fontSize: 70.0,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold),
                      beginColor: const Color.fromARGB(255, 255, 250, 138),
                      endColor: const Color.fromARGB(255, 221, 172, 23),
                      //times: 10,
                      duration: const Duration(seconds: 2)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.history_toggle_off,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Text(
                          "Updated at : ${data.updateTime.split(".")[0]}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height ,
                    child: ListView.builder(
                        itemCount: data.resultData.length,
                        itemBuilder: (context, index) {
                          DateFormat inputFormat = DateFormat('HH:mm:ss');
                          DateTime dateTime = inputFormat
                              .parse(data.resultData[index].openTime ?? "--");
            
                          // Format the DateTime in 12-hour format
                          String formattedTime =
                              DateFormat('hh:mm a').format(dateTime);
            
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Card(
                                elevation: 5,
                                surfaceTintColor:Colors.white,
                                 color:(index%2!=0)?Colors.blue:Colors.blue.withOpacity(0.8),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: Text(formattedTime , style: const TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold,color: whiteColor),),
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              const Opacity(
                                                opacity:0.5,
                                                child: Text("Set", style:  TextStyle(
                                                    fontSize: 16, fontWeight: FontWeight.bold,color: whiteColor),),
                                              ),
                                              Text(data.resultData[index]
                                                      .resultSet ??
                                                  "--", style: const TextStyle(
                                                  fontSize: 16, fontWeight: FontWeight.bold,color: whiteColor),)
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              const Opacity(
                                                opacity:0.5,
                                                child: Text("Value", style: TextStyle(
                                                    fontSize: 16, fontWeight: FontWeight.bold,color: whiteColor),),
                                              ),
                                              Text(data.resultData[index]
                                                      .value ??
                                                  "--", style: const TextStyle(
                                                  fontSize: 16, fontWeight: FontWeight.bold,color: whiteColor),)
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              const Opacity(
                                                opacity:0.5,
                                                child: Text("2D", style: TextStyle(
                                                    fontSize: 16, fontWeight: FontWeight.bold,color: whiteColor,),),
                                              ),
                                              Text(
                                                  data.resultData[index].twod ??
                                                      "--", style: const TextStyle(color: yellowColor,
                                                  fontSize: 18, fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                            ],
                          );
                        }),
                  ),
                  ///Ads
                  IgnorePointer(
                    ignoring: true,
                    child: SizedBox(
                      height: 100,
                      child: AdWidget(
                        ad: rewardedAdManager.getBannerAd()..load(),
                        key: UniqueKey(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
