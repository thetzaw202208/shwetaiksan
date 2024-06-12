import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shwetaiksan/constants/color_const.dart';
import 'package:shwetaiksan/constants/dimens.dart';
import 'package:shwetaiksan/constants/font.dart';
import 'package:shwetaiksan/constants/img.dart';
import 'package:shwetaiksan/generated/locale_keys.g.dart';
import 'package:shwetaiksan/provider/deposit_provider.dart';
import 'package:shwetaiksan/screens/home/home_screen.dart';
import 'package:shwetaiksan/utils/screen_extension.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../provider/withdraw_provider.dart';

class WithdrawDetailsScreen extends StatelessWidget {
  const WithdrawDetailsScreen({super.key, required this.image, required this.id, required this.name});
  final String image,name;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: whiteColor,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   actions: [
      //     IconButton(onPressed: (){
      //       Navigator.pop(context);
      //     }, icon: const Icon(Icons.close_rounded))
      //   ],
      // ),
      body: Consumer<WithdrawProvider>(
        builder: (context,data,_)=>
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: const Icon(Icons.close_rounded,weight: 90,size: 30,)),
                  ),
                  Image.asset(image,width: 70,height: 70,),

                  const DottedLine(),
                  const SizedBox(height: 10,),
                  Card(
                    color: Colors.blue.withOpacity(0.3),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(LocaleKeys.kCheckBalanceBeforeWithdraw.tr(),style: menuLabelTextStyle,),
                          Text(LocaleKeys.kWithdrawInfo.tr(),style: menuLabelTextStyle,),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  // Row(
                  //   children: [
                  //     Text("$name အကောင့် ",style: labelSmallTextStyle,),
                  //     const SizedBox(width: 10,),
                  //     Text("${data.phoneNumber}"),
                  //     const SizedBox(width: 10,),
                  //     GestureDetector(
                  //       onTap: ()async{
                  //         data.onTapCopyIcon();
                  //         await Clipboard.setData(
                  //             ClipboardData(
                  //                 text:
                  //                 "${data.phoneNumber}"));
                  //
                  //         // data.showToastMsg(
                  //         //     "Copied to clipboard",context);
                  //       },
                  //       child: Image.asset(kCopyImgPath,color: Colors.green,width: 20,height: 20,),
                  //     ),
                  //     SizedBox(width: 5,),
                  //     if(data.onTapCopy) Text("Copied",style: copyTextStyle,),
                  //   ],
                  // ),
                  //const SizedBox(height: 10,),
                  // Row(
                  //   children: [
                  //     Text("$name နာမည် ",style: labelSmallTextStyle,),
                  //     const SizedBox(width: 10,),
                  //     Text("${data.name}"),
                  //     const SizedBox(width: 10,),
                      // GestureDetector(
                      //   onTap: ()async{
                      //     data.onTapCopyIcon();
                      //     await Clipboard.setData(
                      //         ClipboardData(
                      //             text:
                      //             "${data.name}"));
                      //
                      //     // data.showToastMsg(
                      //     //     "Copied to clipboard",context);
                      //   },
                      //   child: Image.asset(kCopyImgPath,color: Colors.green,width: 20,height: 20,),
                      // ),
                      // SizedBox(width: 5,),
                      // if(data.onTapCopy) Text("Copied",style: copyTextStyle,),
                  //   ],
                  // ),
                  //const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .3,
                          child:  Text(LocaleKeys.kDepositLimit.tr(),style: labelSmallTextStyle,)),
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .6,
                        child: TextField(
                          controller: data.amount,
                          decoration: InputDecoration(
                            //hintText: "ငွေပမာဏ ရိုက်ထည့်ပါ",

                            //hintTextDirection: TextDirection.ltr,
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.2),
                                fontSize: 14,
                              ),
                              contentPadding: const EdgeInsets.only(
                                  top: 10, right: 10, left: 10),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.circular(10))),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .3,
                          child:  Text("${LocaleKeys.kYour.tr()} $name ${LocaleKeys.kAccount.tr()}",style: labelSmallTextStyle,)),
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .6,
                        child: TextField(
                          controller: data.accountNo,
                          decoration: InputDecoration(
                            //hintText: "ထည့်ပါ",

                            //hintTextDirection: TextDirection.ltr,
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.2),
                                fontSize: 14,
                              ),
                              contentPadding: const EdgeInsets.only(
                                  top: 10, right: 10, left: 10),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.circular(10))),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .3,
                          child:  Text("${LocaleKeys.kYour.tr()} $name ${LocaleKeys.kAccountName.tr()}",style: labelSmallTextStyle,)),
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .6,
                        child: TextField(
                          controller: data.accountName,
                          decoration: InputDecoration(
                            //hintText: "ငွေပမာဏ ရိုက်ထည့်ပါ",

                            //hintTextDirection: TextDirection.ltr,
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.2),
                                fontSize: 14,
                              ),
                              contentPadding: const EdgeInsets.only(
                                  top: 10, right: 10, left: 10),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.circular(10))),
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),



                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.kWithdrawCloseTime.tr(),style: copyTextStyle,),
                        Text(LocaleKeys.kWithdrawOpenTime.tr(),style: copyTextStyle,)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text("${LocaleKeys.kHowToWithdraw.tr()}",style: labelSmallTextStyle,),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: YoutubePlayer(
                      controller: data.controller,
                      topActions: [
                        SizedBox(width: 8,),
                        Text(data.controller.metadata.title)
                      ],
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.blueAccent,
                      onReady: () {
                        print('Player is ready.');
                      },
                      onEnded: (datas) {
                        //data.controller.load('iLnmTe5Q2Qw');
                      },
                    ),
                  ),
                  // Text("ငွေလွှဲရာတွင် မှတ်ချက်၌ ကျေးဇူးပြု၍ အောက်ဖော်ပြပါ အချက်များထဲမှ တစ်ခုရေးသားပေးပါရန်။",style: labelTextStyle,)
                ],
              ),
            ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: (){
            AwesomeDialog(
              context: context,
              dialogType: DialogType.info,
              animType: AnimType.rightSlide,
              title: LocaleKeys.kSuccess.tr(),
              desc: LocaleKeys.kPleaseWait.tr(),
              titleTextStyle: TextStyle(
                  fontSize: 12,fontWeight: bold
              ),
              btnOkText: LocaleKeys.kOkay.tr(),

              btnOkOnPress: () {
context.navigateAndRemoveUntil(const MyHomePage(),false);
              },
            ).show();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(smallBorder),
              color: goldColor,
            ),
            child:  Center(child: Text(LocaleKeys.kConfirm.tr(),style: labelTextStyle,)),
          ),
        ),
      ),

    );
  }
}
