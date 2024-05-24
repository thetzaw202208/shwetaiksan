import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shwetaiksan/provider/three_d_provider.dart';
import 'package:shwetaiksan/provider/two_d_provider.dart';
import 'package:shwetaiksan/screens/3d/three_d_screen.dart';
import 'package:shwetaiksan/screens/home/home_screen.dart';
import 'package:shwetaiksan/utils/screen_extension.dart';

import '../../utils/dialogs.dart';

class ThreeDDetailsScreen extends StatelessWidget {
  const ThreeDDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                context.navigateAndRemoveUntil(ThreeDScreen(), true);
              },
              icon: const Icon(
                Icons.add,
                size: 30,
              ))
        ],
      ),
      body: Consumer<ThreeDProvider>(
        builder: (context, data, _) =>
        // data.isLoading? BackdropFilter(
        //   filter: ImageFilter.blur(
        //       sigmaX: 10, sigmaY: 10),
        //   child: const Center(child: DialogUtils(),),
        // ):
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(1),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("ဂဏန်း",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    Text("ငွေပမာဏ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    Text("ပြင် / ဖျက်",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .6,
                //width: MediaQuery.of(context).size.width*.12,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: data.orderList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            (data.orderList[index].number.toString().length < 3&&data.orderList[index].number.toString().length > 1)
                                ? "0${data.orderList[index].number}":(data.orderList[index].number.toString().length < 2)
                                ?"00${data.orderList[index].number}"
                                : "${data.orderList[index].number}"),
                        Text(data.orderList[index].amount.toString()),
                        Row(
                          children: [
                            GestureDetector(child: const Icon(Icons.edit)),
                            const SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                                onTap: () {
                                  print("Index is $index");
                                },
                                child: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const DottedLine(),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("${data.selectedNumber.length}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.red)),
                        const Text(
                          "  ကွက်",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("စုစုပေါင်းထိုးငွေ  : "),
                        Text(" ${data.totalAmount} ",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.red)),
                        const Text(" ကျပ်"),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer<TwoDProvider>(
        builder: (context, data, _) => Padding(
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.rightSlide,
                title: '',
                desc: 'သေချာပြီလား',
                btnCancelText: "ပြန်စစ်ဆေးမည်",
                btnOkText: "သေချာပြီ",
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  data.enableLoading();
                  Future.delayed(const Duration(seconds: 2), () {
                    data.disableLoading();
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.rightSlide,
                      title: 'ဂုဏ်ယူပါတယ်',
                      desc: 'လုပ်ဆောင်မှု အောင်မြင်ပါသည်',
                      btnCancelText: "မှတ်တမ်း",
                      btnOkText: "မူလ",
                      btnCancelOnPress: () {
                        context.navigateAndRemoveUntil(
                            const MyHomePage(), false);
                      },
                      btnOkOnPress: () {
                        context.navigateAndRemoveUntil(
                            const MyHomePage(), false);
                      },
                    ).show();
                  });
                },
              ).show();
            },
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 10,
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * .2,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 196, 64),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: data.isLoading
                        ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                        : const Text(
                      "ထိုးမည်",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
