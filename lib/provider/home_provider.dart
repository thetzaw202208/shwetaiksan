
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shwetaiksan/constants/img.dart';
import 'package:shwetaiksan/network/data_agent/get_balance/get_balance_data_agent.dart';
import 'package:shwetaiksan/network/data_agent/get_balance/get_balance_data_agent_impl.dart';
import 'package:shwetaiksan/screens/2d/two_d_screen.dart';
import 'package:shwetaiksan/screens/3d/three_d_screen.dart';
import 'package:shwetaiksan/screens/deposit/deposit_screen.dart';
import 'package:shwetaiksan/screens/fortune/fortune_wheel_screen.dart';
import 'package:shwetaiksan/screens/live_result/live_and_result_screen.dart';
import 'package:shwetaiksan/screens/withdraw/withdraw_screen.dart';
import 'package:shwetaiksan/utils/screen_extension.dart';

import '../network/static_vo/home_menu_vo.dart';
import '../screens/login/login_screen.dart';

class HomeProvider extends ChangeNotifier {
  bool isVisible = false;
  String? name,phone;
  String? balanceString="0";
  SharedPreferences? sh;
final GetBalanceDataAgent _getBalanceDataAgent=GetBalanceDataAgentImpl();
  List<HomeMenuVO> menuList=[
    HomeMenuVO(1, "2D",kTwoDImgPath),
    HomeMenuVO(2, "3D",kThreeDImgPath),
    HomeMenuVO(3, "Live",kLiveImgPath),
    HomeMenuVO(4, "ငွေသွင်း",kPaymentImgPath),
    HomeMenuVO(5, "ငွေထုတ်",kPaymentImgPath),
    HomeMenuVO(6, "Spin Wheel",spinWheelImg),

  ];
  String selectedLan = "", showLan = "";
  bool isLoading = false;
  HomeProvider(){

    getUserInfo();
    getUserBalanceData();

  }
  refresh(){
    getUserBalanceData();
    Future.delayed(const Duration(seconds: 2),(){
      disableLoading();
    });
    notifyListeners();
  }
  getUserInfo()async{
     sh=await SharedPreferences.getInstance();
    name=sh?.getString("name");
    phone=sh?.getString("phone");
     notifyListeners();


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
  getUserBalanceData()async{
    sh=await SharedPreferences.getInstance();

    phone=sh?.getString("phone")??"";
    print("Call balance api $phone");
    _getBalanceDataAgent.getUserBalance(phone??"").then((value) {
      print("Success balance is ${value.code}");
      if(value.code==200){
        balanceString=value.data?.balance;
        print("Success balance is $balanceString");
      }else{
        balanceString="0";
        print("Success balance is $balanceString");
        notifyListeners();
      }
      notifyListeners();
    });
  }
  goScreen(int index,BuildContext context){
    switch(index){
      case 0: context.navigateAndRemoveUntil(const TwoDScreen(), true);
      case 1: context.navigateAndRemoveUntil(const ThreeDScreen(), true);
      case 2: context.navigateAndRemoveUntil(const LiveAndResultScreen(), true);
      case 3: context.navigateAndRemoveUntil(const DepositScreen(), true);
      case 4: context.navigateAndRemoveUntil(const WithdrawScreen(), true);
      case 5: context.navigateAndRemoveUntil(const SpinWheel(), true);
    }
    notifyListeners();
}
  logout(BuildContext context)async{
    sh?.setBool("isLogin", false);
    context.navigateAndRemoveUntil(const LoginScreen(), false);
    notifyListeners();
  }
  setVisible() {
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


}
