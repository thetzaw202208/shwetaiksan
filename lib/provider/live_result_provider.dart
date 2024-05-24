import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shwetaiksan/network/data_agent/live/live_data_agent.dart';
import 'package:shwetaiksan/network/data_agent/live/live_data_agent_impl.dart';

import '../network/response_vo/live_data_response_vo.dart';
import '../screens/ads/rewarded_ads.dart';

class LiveAndResultProvider extends ChangeNotifier {
  LiveDataAgent liveDataAgent = LiveDataAgentImpl();
  Live? liveData;
  Timer? _timer;
  List<Result> resultData=[];
  String updateTime="--";
  RewardedAdManager rewardedAdManager = RewardedAdManager();
  LiveAndResultProvider() {

    _timer=Timer.periodic(const Duration(seconds: 1), (timer) {
      getLiveData();
    });
    notifyListeners();
  }
@override
  dispose(){
  super.dispose();

    _timer?.cancel();
}
  getLiveData() {
    liveDataAgent.getLiveData().then((value) {
      liveData = value.live;
      resultData=value.result??[];
      if(resultData.isNotEmpty&&liveData!=null){
        ///One
         if(resultData[0].twod=="--"){
           updateTime=liveData?.time.toString()??"--";
         }else{
           updateTime=resultData[0].openTime.toString()??"--";
         }
         ///Two
         if(resultData[1].twod=="--"){
           updateTime=liveData?.time.toString()??"--";
         }else{
           updateTime=resultData[1].openTime.toString()??"--";
         }
        ///Three
         if(resultData[2].twod=="--"){
           updateTime=liveData?.time.toString()??"--";
         }else{
           updateTime=resultData[2].openTime.toString()??"--";
         }
         ///Four
         if(resultData[3].twod=="--"){
           updateTime=liveData?.time.toString()??"--";
         }else{
           updateTime=resultData[3].openTime.toString()??"--";
         }
      }

      notifyListeners();
    });
  }
}
