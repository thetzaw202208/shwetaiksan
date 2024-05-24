import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shwetaiksan/constants/color_const.dart';
import 'package:shwetaiksan/constants/dimens.dart';
import 'package:shwetaiksan/constants/font.dart';
import 'package:shwetaiksan/constants/img.dart';
import 'package:shwetaiksan/provider/deposit_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
      body: Consumer<DepositProvider>(
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
                          Text("အော်ဒါတင်ခြင်း မပြုလုပ်မီ ငွေလက်ကျန် အရင်စစ်ဆေးပါ။",style: menuLabelTextStyle,),
                          Text("သင့်အကောင့်ထဲသို့ ငွေရောက်ရန် ကြာမြင့်ချိန်သည် အနည်းဆုံး ၁၀ မိနစ်မှ ငွေထုတ်သူ အနည်းအများပေါ် မူတည်၍ နာရီပိုင်းအထိကြာမြင့်နိုင်ပါ၍ နားလည်ပေးနိုင်ပါရန် ကြိုတင် အသိပေးအပ်ပါသည်။",style: menuLabelTextStyle,),
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
                          child: const Text("Amount (2,000 - 1,000,000)",style: labelSmallTextStyle,)),
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
                          child:  Text("သင့် $name အကောင့်",style: labelSmallTextStyle,)),
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
                          child:  Text("သင့် $name အကောင့်နာမည်",style: labelSmallTextStyle,)),
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SizedBox(
                  //         width: MediaQuery.of(context).size.width * .3,
                  //         child:  Text("$name လုပ်ဆောင်မှုအမှတ်",style: labelSmallTextStyle,)),
                  //     SizedBox(
                  //       height: 40,
                  //       width: MediaQuery.of(context).size.width * .6,
                  //       child: TextField(
                  //         controller: data.transactionID,
                  //         decoration: InputDecoration(
                  //           //hintText: "ငွေပမာဏ ရိုက်ထည့်ပါ",
                  //
                  //           //hintTextDirection: TextDirection.ltr,
                  //             hintStyle: TextStyle(
                  //               color: Colors.black.withOpacity(0.2),
                  //               fontSize: 14,
                  //             ),
                  //             contentPadding: const EdgeInsets.only(
                  //                 top: 10, right: 10, left: 10),
                  //             border: OutlineInputBorder(
                  //                 borderSide: const BorderSide(color: Colors.blueGrey),
                  //                 borderRadius: BorderRadius.circular(10))),
                  //         keyboardType: TextInputType.number,
                  //         style: const TextStyle(
                  //             color: Colors.black, fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 10,),


                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text("ည ၁၂ နာရီမှ နောက်တနေ့နံနက် ၉ နာရီ အတွင်း ငွေထုတ်ခြင်း ဆောင်ရွက်ပေးနိုင်မည် မဟုတ်ပါ။",style: copyTextStyle,),
                        Text("ငွေထုတ်ချိန်အား နံနက် ၉ နာရီ  -  ည ၁၂ နာရီ မတိုင်ခင် အထိသာ လက်ခံထားပါသည်။",style: copyTextStyle,)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text("$name ငွေထုတ်နည်း ကြည့်ရန်",style: labelSmallTextStyle,),
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
              title: 'အောင်မြင်ပါသည်',
              desc: 'ခေတ္တစောင့်ဆိုင်းပေးပါ',
              titleTextStyle: TextStyle(
                  fontSize: 12,fontWeight: bold
              ),
              btnOkText: "အိုကေ",

              btnOkOnPress: () {

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
            child: const Center(child: Text("အတည်ပြုမည်",style: labelTextStyle,)),
          ),
        ),
      ),

    );
  }
}
