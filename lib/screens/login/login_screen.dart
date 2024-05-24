import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shwetaiksan/constants/color_const.dart';
import 'package:shwetaiksan/constants/dimens.dart';
import 'package:shwetaiksan/constants/font.dart';
import 'package:shwetaiksan/provider/login_provider.dart';
import 'package:shwetaiksan/provider/register_provider.dart';
import 'package:shwetaiksan/screens/register/register_screen.dart';
import 'package:shwetaiksan/screens/reusable_widgets/text_field.dart';
import 'package:shwetaiksan/utils/screen_extension.dart';

import '../../constants/img.dart';
import '../../generated/locale_keys.g.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(1),

        //extendBodyBehindAppBar: true,
        body: Consumer<LoginProvider>(
          builder: (context, data, _) {
            data.init(context);
            return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          data.showPopupMenu(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child: Row(
                            children: [

                                Image.asset(
                                  data.selectedLan == ""||data.selectedLan=="English"
                                          ? kUSAFlagPath
                                          : kMyanmarFlagBigPath,
                                  scale: 1,
                                  width: 18,
                                  height: 18,
                                ),


                              kSBoxW5x,
                              Text(
                                data.showLan,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              kSBoxW5x,
                              Image.asset(kLanguageIconPath),


                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset("assets/images/logo.png"),
                   Text(
                    LocaleKeys.kHello.tr(),
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: goldColor
                        // foreground: Paint()
                        //   ..shader = linearAppBar
                        //       .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                        ),
                  ),
                   Text(
                    LocaleKeys.kWelcome.tr(),
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: goldColor
                        // foreground: Paint()
                        //   ..shader = linearAppBar
                        //       .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                        ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  if (!data.phone.text.startsWith("0", 0)&&data.phone.text.isNotEmpty)
                     Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Opacity(
                          opacity: 0.7,
                          child: Text(
                              LocaleKeys.kPhoneErrorHint.tr(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 5,
                  ),
                  ReusableTextField(
                    prefixWidget:  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Opacity(opacity: 0.5, child: Icon(Icons.account_box)),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 8.0),
                        //   child: Text(
                        //     "09",
                        //     style: TextStyle(
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.w600,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    width: width * .9,
                    inputType: TextInputType.phone,
                    onChanged: (text) {
                      data.updatePhoneText(text);
                    },
                    radius: largeBorder,
                    hintText: LocaleKeys.kPhoneHint.tr(),
                    controller: data.phone,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ReusableTextField(
                    prefixWidget: const Opacity(
                        opacity: 0.5, child: Icon(Icons.password)),
                    suffixWidget: GestureDetector(
                      onTap: () {
                        data.visibilityOnOff();
                      },
                      child: Icon(data.isVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    width: width * .9,
                    obscure: !data.isVisible,
                    onChanged: (text) {
                      data.password.text = text;
                      data.updateButtonColor();
                    },
                    radius: largeBorder,
                    hintText: LocaleKeys.kPwdHint.tr(),
                    controller: data.password,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.navigateAndRemoveUntil(
                          const RegisterScreen(), false);
                    },
                    child:  Text(
                      LocaleKeys.kNoAccount.tr(),
                      style: TextStyle(
                          fontSize: font12,
                          fontWeight: FontWeight.bold,
                          color: goldColor
                          // foreground: Paint()
                          //   ..shader = linearAppBar
                          //       .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IgnorePointer(
                    ignoring: data.phone.text.isEmpty ||
                        data.password.text.isEmpty ||
                        data.isLoading,
                    child: GestureDetector(
                      onTap: () {
                        print("tappinnnnnnn");
                        data.enableLoading();
                        data.updateButtonColor();
                        Future.delayed(const Duration(seconds: 1), () {
                          data.loginUser(
                              data.phone.text, data.password.text, context);
                        });
                      },
                      child: Container(
                        height: 50,
                        width: width * .8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(largeBorder),
                            color: data.buttonColor),
                        child: Center(
                          child: data.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: whiteColor,
                                  ),
                                )
                              :  Text(
                            LocaleKeys.kSignIn.tr(),
                                  style: TextStyle(color: whiteColor),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );},
        ),
      ),
    );
  }
}
