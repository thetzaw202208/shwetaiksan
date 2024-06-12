import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shwetaiksan/constants/color_const.dart';
import 'package:shwetaiksan/network/data_agent/login/login_data_agent.dart';
import 'package:shwetaiksan/network/data_agent/login/login_data_agent_impl.dart';
import 'package:shwetaiksan/screens/home/home_screen.dart';
import 'package:shwetaiksan/utils/screen_extension.dart';

import '../constants/img.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  Color buttonColor = Colors.grey.withOpacity(0.5);
  bool isLoading = false;
  bool isVisible = false;
  String selectedLan = "", showLan = "";
  // ignore: prefer_final_fields
  LoginDataAgent _loginDataAgent = LoginDataAgentImpl();

  LoginProvider() {
    notifyListeners();
  }
  void showPopupMenu(BuildContext context) {
    // Display the popup menu when the custom text is tapped
    final RenderBox bar = context.findRenderObject() as RenderBox;
    final Offset position = bar.localToGlobal(Offset.zero);

    showMenu<String>(
      surfaceTintColor: Colors.white.withOpacity(0.5),
      color: const Color(0xfff6f6f6),
      context: context,
      position: RelativeRect.fromLTRB(
        580,
        kToolbarHeight + 20,
        position.dx,
        position.dy + kToolbarHeight + bar.size.height,
      ),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'English',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Image.asset(
                  kUSAFlagPath,
                  width: 20,
                  height: 20,
                  // width: 18,
                  // height: 20,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text('  English', textAlign: TextAlign.start),
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                (selectedLan == "English") ? kCheckedImgPath : kNoCheckImgPath,
                width: 24,
                height: 30,
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'မြန်မာ',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Image.asset(
                  kMyanmarFlagBigPath,
                  width: 20,
                  height: 20,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  'မြန်မာ',
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                (selectedLan == "မြန်မာ") ? kCheckedImgPath : kNoCheckImgPath,
                width: 24,
                height: 30,
              ),
            ],
          ),
        ),
      ],
    ).then((value) async {
      if (value != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        selectedLan = value;
        showLan = selectedLan;

        if (selectedLan == "English") {
          sharedPreferences.setString("lan", "en");
          context.setLocale(const Locale('en'));
        }
        if (selectedLan == "မြန်မာ") {
          sharedPreferences.setString("lan", "my");
          context.setLocale(const Locale('my'));
        }
        notifyListeners();
        // Handle the selected menu item here
      }
    });
  }

  init(BuildContext context) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    var lan = sh.getString("lan");
    if (lan == "en" || lan == null) {
      context.setLocale(const Locale("en"));
      selectedLan = "English";
      showLan = selectedLan;
      notifyListeners();
    }
    if (lan == "my") {
      context.setLocale(const Locale("my"));
      selectedLan = "မြန်မာ";
      showLan = selectedLan;
      notifyListeners();
    }
  }

  visibilityOnOff() {
    isVisible = !isVisible;
    notifyListeners();
  }

  enableLoading() {
    isLoading = true;
    notifyListeners();
  }

  disableLoading() {
    isLoading = false;
    notifyListeners();
  }

  updatePhoneText(String phoneText) {
    phone.text = phoneText;
    notifyListeners();
  }

  loginUser(String phone, String password, BuildContext context) async {
    SharedPreferences sh = await SharedPreferences.getInstance();

    try {
      final value = await _loginDataAgent.loginUser(phone, password).timeout(
        Duration(minutes: 1),
        onTimeout: () {
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );

      if (value.code == 200) {
        sh.setBool("isLogin", true);
        print("Here is data ${value.data?.phone}");
        sh.setString("name", value.data?.name ?? "");
        sh.setString("phone", value.data?.phone ?? "");

        disableLoading();
        context.navigateAndRemoveUntil(const MyHomePage(), false);
      } else if (value.code == 201) {
        disableLoading();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'ဝမ်းနည်းပါတယ်',
          desc: 'အချက်အလက် မှားယွင်းနေပါသည်',
          btnOkText: "အိုကေ",
          btnOkOnPress: () {},
        ).show();
        notifyListeners();
      }
    } on TimeoutException catch (_) {
      disableLoading();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Timeout',
        desc: 'The request has timed out. Please try again later.',
        btnOkText: "OK",
        btnOkOnPress: () {},
      ).show();
      notifyListeners();
    } catch (error) {
      disableLoading();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'An unexpected error occurred. Please try again later.',
        btnOkText: "OK",
        btnOkOnPress: () {},
      ).show();
      notifyListeners();
    }
  }

  void updateButtonColor() {
    if (phone.text.isEmpty || password.text.isEmpty || isLoading) {
      buttonColor = Colors.grey.withOpacity(0.5);
    } else {
      buttonColor = goldColor; // Set your desired color here
    }
    notifyListeners();
  }
}
