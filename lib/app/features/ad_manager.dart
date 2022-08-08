import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      //return "ca-app-pub-6938134630901841/5031608905";
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      // return 'ca-app-pub-6938134630901841/3840550116';
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  String get interstialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6938134630901841/8338892892";
    } else if (Platform.isIOS) {
      // return 'ca-app-pub-6938134630901841/8658596672';
      return 'ca-app-pub-3940256099942544/1033173712';
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  BannerAd createBannerAd() {
    BannerAd ad = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError err) => ad.dispose(),
      ),
    );

    return ad;
  }

  Future<void> createInterstialAd(context) async {
    InterstitialAd? myInterstitial;
    await InterstitialAd.load(
      adUnitId: interstialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          myInterstitial = ad;
          myInterstitial?.show();
        },
        onAdFailedToLoad: (_) => myInterstitial?.dispose(),
      ),
    );
  }
}
