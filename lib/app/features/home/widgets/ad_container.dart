import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

containerAd(AdWidget? adWidget, BannerAd? ad) {
  return Container(
    alignment: Alignment.center,
    width: ad?.size.width.toDouble(),
    height: ad?.size.height.toDouble(),
    child: adWidget ?? const SizedBox.shrink(),
  );
}
