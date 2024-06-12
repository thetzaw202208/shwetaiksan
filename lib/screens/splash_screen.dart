import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shwetaiksan/provider/withdraw_provider.dart';
import 'package:shwetaiksan/screens/home/home_screen.dart';

import 'login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }
  init()async{
    SharedPreferences sh=await SharedPreferences.getInstance();
    var isLogin= sh.getBool("isLogin");
    if(isLogin==true){
      Future.delayed(const Duration(seconds: 2),(){
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MyHomePage()),
                (Route<dynamic> route) => false);
      });
    }else if(isLogin==null || isLogin==false){
      Future.delayed(const Duration(seconds: 2),(){
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<WithdrawProvider>(
      builder: (context, data, _) {
        data.init(context);
        return Scaffold(
        body: Center(
          child: Image.asset("assets/images/launcher.png"),
        ),
      );}

    );
  }
}
