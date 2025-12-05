import 'package:flutter/material.dart';
import 'package:magic_remove/core/widgets/interstitial_ad_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'services/ads/ads_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.instance.initialize();

  await AdsService.instance.init();
  InterstitialAdManager.load();

  final prefs = await SharedPreferences.getInstance();
  final seenIntro = prefs.getBool('seen_intro') ?? false;

  runApp(MyApp(seenIntro: seenIntro));
}
