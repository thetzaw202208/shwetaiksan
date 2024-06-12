import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shwetaiksan/constants/font.dart';
import 'package:shwetaiksan/provider/deposit_provider.dart';

import '../../generated/locale_keys.g.dart';

class SocialContact {
  int id;
  String imgPath;

  SocialContact(this.id, this.imgPath);
}

class Payment {
  int id;
  String imgPath;
  String name;

  Payment(this.id, this.imgPath, this.name);
}

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.kDeposit.tr(),style: appBarTextStyle,),
      ),
      body: Consumer<DepositProvider>(
        builder: (context, data, _) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  LocaleKeys.kNotice.tr(),
                  style: errorTextStyle,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  LocaleKeys.kNotice1.tr(), style: labelSmallTextStyle,),
              ), const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  LocaleKeys.kNotice2.tr(), style: labelSmallTextStyle,),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.socialList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            data.selectSocialAccount(index, context);
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(5),
                            elevation: 5,
                            child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Image.asset(
                                    data.socialList[index].imgPath)),
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  LocaleKeys.kAcceptedPaymentType.tr(),
                  style: labelSmallTextStyle,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: (190 * data.paymentList.length).toDouble(),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.3),
                  itemCount: data.paymentList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                          data.selectPayment(index, context,data.paymentList[index].id,data.paymentList[index].imgPath,data.paymentList[index].name);
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
                                    data.paymentList[index].imgPath,
                                    width: 80,
                                    height: 80,
                                  ),
                                  Container(
                                      width: 200,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.7),
                                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5))),
                                      child: Center(
                                        child: Text(
                                          data.paymentList[index].name,
                                          style: paymentLabelTextStyle,
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
            ],
          ),
        ),
      ),
    );
  }
}
