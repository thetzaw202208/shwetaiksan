import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shwetaiksan/constants/img.dart';
import 'package:shwetaiksan/screens/deposit/deposit_details_screen.dart';
import 'package:shwetaiksan/screens/login/login_screen.dart';
import 'package:shwetaiksan/screens/withdraw/widthdraw_details_screen.dart';
import 'package:shwetaiksan/utils/screen_extension.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../screens/deposit/deposit_screen.dart';

class WithdrawProvider extends ChangeNotifier{
  int? selectSocialAcc;
  int? selectPaymentType;
  String? phoneNumber,name;
  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;
  double volume = 100;
  bool muted = false;
  bool onTapCopy = false;
  bool isPlayerReady = false;
  TextEditingController amount=TextEditingController();
  TextEditingController accountNo=TextEditingController();
  TextEditingController accountName=TextEditingController();
  TextEditingController transactionID=TextEditingController();
  late YoutubePlayerController controller;
  String? accountNumber;
  List<SocialContact> socialList=[
    SocialContact(1, kMessengerImgPath),
    SocialContact(2, kTelegramImgPath),
    SocialContact(3, kViberImgPath),
    SocialContact(4, kFacebookImgPath),
  ];
  List<Payment> paymentList=[
    Payment(1, kKBZBankImgPath,"KBZ banking"),
    Payment(2, kKBZPayImgPath,"kPay"),
    Payment(3, kAYABankImgPath,"AYA Banking"),
    Payment(4, kAYAPayImgPath,"AYA Pay"),
    Payment(4, kWaveMoneyImgPath,"Wave Money"),
  ];
  String selectedLan = "", showLan = "";
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
  WithdrawProvider(){
    phoneNumber="09963258741";
    name="Thet Zaw Latt";
    controller = YoutubePlayerController(
      initialVideoId: 'lK3bCEYDcuI',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    videoMetaData = const YoutubeMetaData();
    playerState = PlayerState.unknown;
    notifyListeners();
  }

  onTapCopyIcon(){
    onTapCopy=true;

    notifyListeners();
    Future.delayed(Duration(seconds: 2),(){
      onTapCopy=false;
      notifyListeners();
    });
  }


  void listener() {
    if (isPlayerReady &&  !controller.value.isFullScreen) {

      playerState = controller.value.playerState;
      videoMetaData = controller.metadata;

    }
  }
  showToastMsg(String msg,BuildContext context) {
    showToast(
      msg,
      //position: StyledToastPosition(align: Alignment.center),
      context: context,
      animation: StyledToastAnimation.scale,
    );
  }
  void _launchURL(String urlString) async {
    if (await canLaunchUrl(Uri.parse(urlString))) {
      await launchUrl(Uri.parse(urlString));
    } else {
      throw 'Could not launch $urlString';
    }
  }
  void _launchViber(String phoneNumber) async {
    final url = 'viber://chat?number=$phoneNumber';//viber://add/?number
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  selectSocialAccount(int index,BuildContext context){
    selectSocialAcc=index;
    switch(index){
      case 0: _launchURL("https://m.me/thetzawlatt2021");
      case 1: _launchURL("https://t.me/tzlOfficial");
      case 2: _launchViber("959972018148");
      case 3: _launchURL("https://www.facebook.com/profile.php?id=61557923971876");
    }
    notifyListeners();
  }
  selectPayment(int index,BuildContext context,int id,String img,String name){
    selectPaymentType=index;
    switch(index){
      case 0: context.navigateAndRemoveUntil(WithdrawDetailsScreen(image: img, id: id,name: name,), true);
      case 1: context.navigateAndRemoveUntil(WithdrawDetailsScreen(image: img, id: id,name: name), true);
      case 2: context.navigateAndRemoveUntil(WithdrawDetailsScreen(image: img, id: id,name: name), true);
      case 3: context.navigateAndRemoveUntil(WithdrawDetailsScreen(image: img, id: id,name: name), true);
      case 4: context.navigateAndRemoveUntil(WithdrawDetailsScreen(image: img, id: id,name: name), true);
    }
    notifyListeners();
  }
}