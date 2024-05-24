import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shwetaiksan/constants/color_const.dart';
import 'package:shwetaiksan/constants/dimens.dart';
import 'package:shwetaiksan/constants/font.dart';
import 'package:shwetaiksan/constants/string.dart';
import 'package:shwetaiksan/provider/home_provider.dart';
import 'package:shwetaiksan/screens/fortune/fortune_wheel_screen.dart';
import 'package:shwetaiksan/screens/live_result/live_and_result_screen.dart';
import 'package:shwetaiksan/screens/ads/rewarded_ads.dart';
import 'package:shwetaiksan/screens/2d/two_d_screen.dart';
import 'package:shwetaiksan/screens/login/login_screen.dart';
import 'package:shwetaiksan/utils/mask_string.dart';
import 'package:shwetaiksan/utils/screen_extension.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RewardedAdManager rewardedAdManager = RewardedAdManager();
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    rewardedAdManager.loadRewardAd();
  }

  @override
  void dispose() {
    super.dispose();
    rewardedAdManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   flexibleSpace: Container(
        //     decoration:  BoxDecoration(
        //       gradient: linearAppBar
        //     ),
        //   ),
        // ),
        // bottomNavigationBar: Container(
        //   child: AdWidget(
        //     ad: rewardedAdManager.getBannerAd()..load(),
        //     key: UniqueKey(),
        //   ),
        // ),
        body: Consumer<HomeProvider>(
          builder: (context, data, _) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            data.logout(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blueGrey),
                            child: const Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name ?? "--",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            Text((data.phone ?? "0996538009").maskString())
                          ],
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(Icons.notifications_active),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.refresh),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: Colors.blue.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "ငွေစာရင်းလက်ကျန်",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w100,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                data.setVisible();
                              },
                              child: Icon(
                                data.isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 17,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        ///Balance
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.isVisible ? data.balanceString??"0" : "********",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Opacity(
                              opacity: 0.9,
                              child: Row(
                                children: [
                                  Text("အကူအညီ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                ///Services
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Opacity(opacity: 0.7,child: Text("ဝန်ဆောင်မှုများ",style: labelTextStyle,)),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: SizedBox(
                //     height: 180,
                //     child: GridView.builder(
                //         physics: const NeverScrollableScrollPhysics(),
                //         itemCount: data.menuList.length,
                //         gridDelegate:
                //             const SliverGridDelegateWithFixedCrossAxisCount(
                //                 crossAxisCount: 3,
                //                 childAspectRatio: 1.5,
                //                 mainAxisSpacing: 20,
                //                 crossAxisSpacing: 20),
                //         itemBuilder: (context, index) {
                //           return GestureDetector(
                //             onTap: () {
                //             data.goScreen(index, context);
                //             },
                //             child: data.menuList[index].imgPath != ""
                //                 ? Material(
                //               elevation: 8,
                //               borderRadius: BorderRadius.circular(smallBorder),
                //               child: Container(
                //                       padding: const EdgeInsets.all(defaultPadding),
                //                       height: 70,
                //                       width: MediaQuery.of(context).size.width *
                //                           .25,
                //                       decoration: BoxDecoration(
                //                           color: const Color.fromARGB(
                //                               255, 221, 172, 23),
                //                           borderRadius:
                //                               BorderRadius.circular(smallBorder),
                //                           image:  DecorationImage(
                //                               image: AssetImage(
                //                                   data.menuList[index].imgPath??""))),
                //                     ),
                //                 )
                //                 : Material(
                //               elevation: 8,
                //               borderRadius: BorderRadius.circular(smallBorder),
                //                   child: Container(
                //                       padding: const EdgeInsets.all(10),
                //                       height: 70,
                //                       width: MediaQuery.of(context).size.width *
                //                           .25,
                //                       decoration: BoxDecoration(
                //                         color: const Color.fromARGB(
                //                             255, 221, 172, 23),
                //                         borderRadius: BorderRadius.circular(10),
                //                       ),
                //                       child: Center(
                //                         child: Text(
                //                           data.menuList[index].name ?? "",
                //                           style: const TextStyle(
                //                               fontSize: font16,
                //                               fontWeight: FontWeight.bold,
                //                               color: Colors.white),
                //                         ),
                //                       ),
                //                     ),
                //                 ),
                //           );
                //         }),
                //   ),
                // ),

                SizedBox(
                  height: (45 * data.menuList.length).toDouble(),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.9),
                    itemCount: data.menuList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            data.goScreen(index, context);
                           // data.selectPayment(index, context,data.paymentList[index].id,data.paymentList[index].imgPath,data.paymentList[index].name);
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(5),
                            elevation: 5,
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(height: 5,),
                                    Image.asset(
                                      "${data.menuList[index].imgPath}",
                                      width: 70,
                                      height: 70,
                                    ),
                                    Container(
                                        width: 200,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(0.7),
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5))),
                                        child: Center(
                                          child: Text(
                                            "${data.menuList[index].name}",
                                            style: menuLabelTextStyle,
                                          ),
                                        ))
                                  ],
                                )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                ///History
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Opacity(opacity: 0.7,child: Text("မှတ်တမ်း",style: labelTextStyle,)),
                ),
                Card(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "လတ်တလော",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                rewardedAdManager.showRewardAd();
                              },
                              child: const Card(
                                surfaceTintColor: Colors.white,
                                borderOnForeground: true,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: Text(
                                    "အားလုံး",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  child: Text("2D"),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("2D ထိုးငွေပေးချေမှု")
                              ],
                            ),
                            Text(
                              "-1,000",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w100),
                            ),
                          ],
                        ),
                        const Divider(),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  child: Text("3D"),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("ဆုကြေးငွေ")
                              ],
                            ),
                            Text(
                              "+2,031,000",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w100),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Consumer<HomeProvider>(
          builder: (context, value, _) => Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.withOpacity(0.5),
            child: IgnorePointer(
              ignoring: true,
              child: SizedBox(
                height: 100,
                child: AdWidget(
                  ad: rewardedAdManager.getBannerAd()..load(),
                  key: UniqueKey(),
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}
