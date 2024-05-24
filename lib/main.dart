import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shwetaiksan/provider/deposit_provider.dart';
import 'package:shwetaiksan/provider/three_d_provider.dart';
import 'package:shwetaiksan/provider/two_d_provider.dart';
import 'package:shwetaiksan/provider/withdraw_provider.dart';
import 'package:shwetaiksan/screens/ads/rewarded_ads.dart';
import 'package:shwetaiksan/screens/splash_screen.dart';

import 'generated/codegen_loader.g.dart';

void main() {
 initialization();
  runApp(  EasyLocalization(
    supportedLocales: const [
      Locale(
        'en',
      ),
      Locale("my"),

    ],
    startLocale: const Locale('en'),
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    useFallbackTranslations: true,
    useOnlyLangCode: true,
    assetLoader: const CodegenLoader(),
    child: const MyApp(),
  ));
}

initialization()async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  RewardedAdManager.initialization();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [

        ChangeNotifierProvider<TwoDProvider>(
            create: (_) => TwoDProvider()),
        ChangeNotifierProvider<ThreeDProvider>(
            create: (_) => ThreeDProvider()),
        ChangeNotifierProvider<DepositProvider>(
            create: (_) => DepositProvider()),
        ChangeNotifierProvider<WithdrawProvider>(
            create: (_) => WithdrawProvider()),
      ],
      child:  MaterialApp(
        localizationsDelegates:
        context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}


