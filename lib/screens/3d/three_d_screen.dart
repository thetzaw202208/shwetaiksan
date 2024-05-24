import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shwetaiksan/provider/three_d_provider.dart';
import 'package:shwetaiksan/provider/two_d_provider.dart';
import 'package:shwetaiksan/screens/2d/ready_made_choice_two_d_screen.dart';
import 'package:shwetaiksan/utils/screen_extension.dart';

class ThreeDScreen extends StatelessWidget {
  const ThreeDScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Consumer<ThreeDProvider>(
        builder: (context, data, _) => Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 50),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                    // GestureDetector(
                    //   onTap: () {
                    //     context.navigateAndRemoveUntil(
                    //         const ReadyMade2D(), true);
                    //   },
                    //   child: SizedBox(
                    //       height: 40,
                    //       // decoration: BoxDecoration(
                    //       //     color: Colors.blue.withOpacity(0.8),
                    //       //     borderRadius: BorderRadius.circular(10)),
                    //       // padding: const EdgeInsets.symmetric(
                    //       //     horizontal: 15, vertical: 10),
                    //       child: const Center(
                    //           child: Text(
                    //             "အသင့်ရွေး",
                    //             style: TextStyle(
                    //                 fontSize: 13,
                    //                 color: Colors.blue,
                    //                 fontWeight: FontWeight.normal),
                    //           ))),
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: GridView.builder(
                      itemCount: data.items.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          childAspectRatio: 1,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            data.selectNumbers(index);
                          },
                          child: Material(
                            elevation: 10,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0)),
                            ),
                            child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: data.selectedNumber.contains(index)
                                        ? const Color.fromARGB(
                                        255, 236, 196, 64)
                                        : Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5.0),
                                        topRight: Radius.circular(5.0),
                                        bottomLeft: Radius.circular(5.0),
                                        bottomRight: Radius.circular(5.0))),
                                child: Card(
                                  surfaceTintColor: Colors.white,
                                  borderOnForeground: false,
                                  color: data.selectedNumber.contains(index)
                                      ? const Color.fromARGB(255, 236, 196, 64)
                                      : Colors.white,
                                  shadowColor: Colors.white,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            data.items[index] < 10
                                                ? "00${data.items[index]}"
                                                :data.items[index] < 100
                                                ? "0${data.items[index]}": data.items[index].toString(),
                                            style: TextStyle(
                                                color: data.selectedNumber
                                                    .contains(index)
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      LinearProgressIndicator(
                                        backgroundColor: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        value: 0.5,
                                        valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.green),
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: LayoutBuilder(builder: (context, constraints) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        return Consumer<ThreeDProvider>(
          builder: (context, data, _) => Container(
            height: 70 + keyboardHeight,
            color: Colors.blue,
            padding:
            EdgeInsets.only(left: 10.0, right: 10, bottom: keyboardHeight+10,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * .7,
                    child: TextField(
                      controller: data.amount,
                      decoration: InputDecoration(
                          hintText: "ငွေပမာဏ ရိုက်ထည့်ပါ",

                          //hintTextDirection: TextDirection.ltr,
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.2),
                            fontSize: 14,
                          ),
                          contentPadding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10))),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (data.amount.text.isNotEmpty &&
                        data.selectedNumber.isNotEmpty) {
                      if(int.parse(data.amount.text)%100==0) {
                        data.twoDOrder(int.parse(data.amount.text), context);
                      }else{
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'သတိပြုရန်',
                          desc:
                          '၁၀၀ ၏ ဆတိုး ပမာဏသာ ခွင့်ပြုပါသည်',
                          // btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      }
                    }else{
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'သတိပြုရန်',
                        desc:
                        'အချက်အလက် မပြည့်စုံပါ',
                        // btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      ).show();
                    }
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
                      child: const Center(
                          child: Text(
                            "ထိုးမည်",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
