// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "kHello": "Hello",
  "kWelcome": "Welcome from ရွှေတိုက်စံ",
  "kNameHint": "Enter your name",
  "kPhoneHint": "Enter your email or phone",
  "kPwdHint": "Enter your password",
  "kPhoneErrorHint": "Need to enter prefix 09(if Myanmar)",
  "kPwdError": "Password length must have at least 6 ",
  "kAlreadyAccount": "Already have an account? Sig in",
  "kNoAccount": "Don't have an account? Sign up",
  "kSignUp": "Sign up",
  "kSignIn": "Sign in"
};
static const Map<String,dynamic> my = {
  "kHello": "မင်္ဂလာပါ",
  "kWelcome": "ရွှေတိုက်စံ မှ ကြိုဆိုပါတယ်",
  "kNameHint": "အမည် ဖြည့်ပါ",
  "kPhoneHint": "ဖုန်းနံပါတ် ဖြည့်ပါ",
  "kPwdHint": "လျှို့ဝှက်နံပတ် ဖြည့်ပါ",
  "kPhoneErrorHint": "ဖုန်းနံပါတ် ဖြည့်ရာတွင် 09 ထည့်ရန်လိုပါသည်",
  "kPwdError": "လျှို့ဝှက်နံပါတ် အနည်းဆုံး ၆ လုံးရှိရမည်",
  "kAlreadyAccount": "အကောင့်ရှိပါသည် ၊ ဝင်မည်",
  "kNoAccount": "အကောင့်မရှိပါ ၊ ဖွင့်မည်",
  "kSignUp": "အကောင့် ဖွင့်မည်",
  "kSignIn": "အကောင့် ဝင်မည်"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "my": my};
}
