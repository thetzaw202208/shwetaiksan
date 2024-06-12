
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shwetaiksan/constants/color_const.dart';
import 'package:shwetaiksan/constants/dimens.dart';
import 'package:shwetaiksan/constants/font.dart';
import 'package:shwetaiksan/provider/history_provider.dart';
import 'package:shwetaiksan/provider/home_provider.dart';
import 'package:shwetaiksan/screens/login/login_screen.dart';
import 'package:shwetaiksan/utils/mask_string.dart';
import 'package:shwetaiksan/utils/screen_extension.dart';
import 'package:shwetaiksan/utils/thousand_separator_ext.dart';
import '../../generated/locale_keys.g.dart';
import '../history/history.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

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
          builder: (context, data, _) {
            data.init(context);
            return
              Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(defaultPadding),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blueGrey),
                          child: const Icon(Icons.person),
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
                            data.phone!=null ? Text((data.phone)!.maskString()):const Text("________"),
                          ],
                        )
                      ],
                    ),
                     Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                             context.navigateAndRemoveUntil(const HistoryScreen(), true);
                            },
                            child: const Icon(Icons.notifications_active)),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                            onTap: () {
                              data.showPopupMenu(context);
                            },
                            child: const Icon(Icons.language)),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                            onTap: () {
                             context.navigateAndRemoveUntil(const LoginScreen(), false);
                            },
                            child: const Icon(Icons.logout,)),


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
                    child: data.isLoading? Center(child: Column(
                      children: [
                        Text(LocaleKeys.kPleaseWait.tr(),style: leadingTextStyle,),
                        SizedBox(height: 25,),
                        SizedBox(
                            width:20,
                            height: 20,
                            child: CircularProgressIndicator(color: whiteColor,)),
                      ],
                    ),): Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                 Text(
                                   LocaleKeys.kCurrentBalance.tr(),
                                  style: paymentLabelTextStyle,
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
                            GestureDetector(
                                onTap: () {
                                  data.enableLoading();
                                  data.refresh();
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(5),

                                  elevation: 5,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.green),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      children: [
                                        Text(LocaleKeys.kRefresh.tr(),style: labelSmallTextStyle,),
                                        const Icon(Icons.refresh,),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        ///Balance
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  data.isVisible ? int.parse(data.balanceString??"0").formatWithComma() : "********",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  LocaleKeys.kKyat.tr(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                             Opacity(
                              opacity: 0.9,
                              child: Row(
                                children: [
                                  Text(LocaleKeys.kHelp.tr(),
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
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                  child: Opacity(opacity: 0.7,child: Text(LocaleKeys.kServices.tr(),style: labelTextStyle,)),
                ),


                SizedBox(
                  height: (45 * data.menuList.length).toDouble(),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    const SizedBox(height: 5,),
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
                                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5))),
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
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                  child: Opacity(opacity: 0.7,child: Text(LocaleKeys.kHistory.tr(),style: labelTextStyle,)),
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
                             Opacity(
                               opacity: 0.7,
                               child: Text(
                                LocaleKeys.kRecent.tr(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                                           ),
                             ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                context.navigateAndRemoveUntil(const HistoryScreen(), true);
                               // rewardedAdManager.showRewardAd();
                              },
                              child:  Card(
                                surfaceTintColor: Colors.white,
                                borderOnForeground: true,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5),
                                  child: Text(
                                    LocaleKeys.kAll.tr(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
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
                        ChangeNotifierProvider<HistoryProvider>(
                          create: (context) => HistoryProvider(),
                          child: Consumer<HistoryProvider>(
                            builder: (context,provider,_)=>

                               provider.noData==false&&(provider.historyDataList?.isNotEmpty==true)?

                               SizedBox(
                              height: 80,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.blueGrey.withOpacity(0.5)),
                                                  child: Icon(Icons.info,color: Colors.blueGrey,)),
                                              SizedBox(width: 10,),
                                              Text(
                                                provider.historyDataList?[index].type ?? "",
                                                style: appBarTextStyle,
                                              ),
                                            ],
                                          ),

                                         if(provider.historyDataList!.isNotEmpty) Text(
                                              provider.historyDataList?[index].isIncome == 1
                                                  ? "+${provider.historyDataList?[index].amount} MMK"
                                                  : "-${provider.historyDataList?[index].amount} MMK",
                                              style: provider.historyDataList?[index].isIncome == 1
                                                  ? incomeTextStyle
                                                  : outComeTextStyle)
                                        ],
                                      ),

                                     if(index==0) const Divider(),
                                    ],
                                  );
                                },
                                itemCount: 2,
                              ),
                            ):Center(child: Text(LocaleKeys.kNoData.tr()),),
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ],
            ),
          );},
        ),
        // bottomNavigationBar: Consumer<HomeProvider>(
        //   builder: (context, value, _) => Container(
        //     padding: EdgeInsets.symmetric(horizontal: 10),
        //     height: 50,
        //     width: MediaQuery.of(context).size.width,
        //     color: Colors.blueGrey.withOpacity(0.5),
        //     child:  GestureDetector(
        //         onTap: () {
        //           context.navigateAndRemoveUntil(const LoginScreen(), false);
        //         },
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(LocaleKeys.kLogout.tr(),style:leadingTextStyle),
        //             SizedBox(width: 10,),
        //             const Icon(Icons.logout,color: whiteColor,),
        //           ],
        //         )),
        //   ),
        // ),
      ),
    );
  }
}
