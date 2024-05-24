import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future<void> navigateAndRemoveUntil(Widget screen,bool value) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
          (Route<dynamic> route) => value,
    );
  }
}
