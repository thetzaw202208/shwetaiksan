import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shwetaiksan/constants/color_const.dart';
import 'package:shwetaiksan/constants/dimens.dart';
import 'package:shwetaiksan/constants/font.dart';
import 'package:shwetaiksan/provider/register_provider.dart';
import 'package:shwetaiksan/screens/reusable_widgets/text_field.dart';
import 'package:shwetaiksan/utils/screen_extension.dart';

import '../../generated/locale_keys.g.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<RegisterProvider>(
      create: (context) => RegisterProvider(),
      child: Scaffold(
        backgroundColor:Colors.white,

        //extendBodyBehindAppBar: true,
        body: Consumer<RegisterProvider>(
          builder: (context, data, _) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(

                children: [
                  const SizedBox(height: 40,),
                  Image.asset("assets/images/logo.png"),
                  Text(
                    LocaleKeys.kHello.tr(),
                    style: const TextStyle(
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
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: goldColor
                      // foreground: Paint()
                      //   ..shader = linearAppBar
                      //       .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ReusableTextField(
                    prefixWidget: const Opacity(
                        opacity: 0.5,
                        child: Icon(Icons.edit)),
                    width: width*.9,
                    onChanged: (text){
                      data.name.text=text;

                    },
                    radius: largeBorder,
                    hintText: LocaleKeys.kNameHint.tr(),
                    controller: data.name,
                  ),
                  const SizedBox(height: 20,),
                  if (!data.phone.text.startsWith("0", 0)&&data.phone.text.isNotEmpty)
                     Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Opacity(
                          opacity: 0.7,
                          child: Text(
                            LocaleKeys.kPhoneErrorHint.tr(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.red
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 5,
                  ),
                  ReusableTextField(
                    prefixWidget: const Row(
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
                    width: width*.9,
                    inputType: TextInputType.phone,
                    onChanged: (text){
                      data.updatePhoneText(text);
                    },
                    radius: largeBorder,
                    hintText: LocaleKeys.kPhoneHint.tr(),
                    controller: data.phone,
                  ),
                  const SizedBox(height: 20,),
                  if (data.password.text.length < 6&&data.password.text.isNotEmpty)
                     Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Opacity(
                          opacity: 0.7,
                          child: Text(
                            LocaleKeys.kPwdError.tr(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.red
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 5,
                  ),
                  ReusableTextField(
                    prefixWidget: const Opacity(
                        opacity: 0.5,
                        child: Icon(Icons.password)),
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
                    onChanged: (text){
                      data.password.text=text;
                      data.updateButtonColor();
                    },
                    radius: largeBorder,
                    hintText: LocaleKeys.kPwdHint.tr(),
                    controller: data.password,
                  ),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      context.navigateAndRemoveUntil(
                          const LoginScreen(),false);
                    },
                    child: Text(
                      LocaleKeys.kAlreadyAccount.tr(),
                      style: const TextStyle(
                        fontSize: font12,
                        fontWeight: FontWeight.bold,
                        color: goldColor
                        // foreground: Paint()
                        //   ..shader = linearAppBar
                        //       .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  IgnorePointer(
                    ignoring: data.name.text.isEmpty||data.phone.text.isEmpty||data.password.text.isEmpty||data.isLoading,
                    child: GestureDetector(
                      onTap: (){
                        print("tappinnnnnnn");
                        data.enableLoading();
                        data.updateButtonColor();
                        Future.delayed(const Duration(seconds: 1),(){
                          data.registerUser(data.name.text, data.phone.text, data.password.text, context);
                        });
                      },
                      child: Container(
                        height: 50,
                        width: width*.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(largeBorder),
                          color: data.buttonColor
                        ),
                        child:  Center(
                          child:data.isLoading?const Center(
                            child: CircularProgressIndicator(color: whiteColor,),
                          ): Text(LocaleKeys.kSignUp.tr(),style: const TextStyle(color: whiteColor),),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
