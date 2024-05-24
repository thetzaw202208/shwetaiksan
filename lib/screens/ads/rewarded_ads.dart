import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdManager {
  static const String adUnitId = 'ca-app-pub-7319269804560504/6645907620'; // Real IDs////ca-app-pub-1201205120535699/3957153119
  static const String bannerID = 'ca-app-pub-3940256099942544/6300978111'; // Real IDs////ca-app-pub-1201205120535699/2003258837

  RewardedAd? _rewardedAd;

  static initialization(){
    MobileAds.instance.initialize();
    }

 BannerAd getBannerAd(){
    BannerAd bannerAd=BannerAd(size: AdSize.fullBanner, adUnitId: bannerID, listener: BannerAdListener(
      onAdClosed: (Ad ad){
        //print("Ad closed");
      },
      onAdFailedToLoad: (Ad ad,LoadAdError error){
        print("Ad fail");
        ad.dispose();
      },
      onAdLoaded: (Ad ad){
        print("Ad loaded");
        //ad.dispose();

      }), request: AdRequest());

  return bannerAd;
  }
    void loadRewardAd(){
    RewardedAd.load(adUnitId: adUnitId, request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (RewardedAd ad){
              _rewardedAd=ad;
            },
            onAdFailedToLoad: (LoadAdError er){
              _rewardedAd?.dispose();
             /// loadRewardAd();
            }));
    }

    void showRewardAd(){
      _rewardedAd?.fullScreenContentCallback=FullScreenContentCallback(onAdShowedFullScreenContent: (RewardedAd ad){

      });
    _rewardedAd?.show(onUserEarnedReward: (AdWithoutView ad,RewardItem point){
      print("Reward point is ${point.amount}");
    });


    }

   void dispose(){
    _rewardedAd?.dispose();
    }
}
