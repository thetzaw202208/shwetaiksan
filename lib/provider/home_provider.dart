
import 'package:flutter/cupertino.dart';
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

  HomeProvider(){

    getUserInfo();
    getUserBalanceData();

  }
  getUserInfo()async{
     sh=await SharedPreferences.getInstance();
    name=sh?.getString("name");
    phone=sh?.getString("phone");
     notifyListeners();


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




}
