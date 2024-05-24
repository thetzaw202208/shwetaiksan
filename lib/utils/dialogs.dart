import 'dart:ui';

import 'package:flutter/material.dart';

class DialogUtils extends StatelessWidget {
  const DialogUtils({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context){
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black
      ),
      child:
      BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 5, sigmaY: 5),
        child: const Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white,),
            Text("လုပ်ဆောင်နေပါသည်......",style: TextStyle(color: Colors.white),)
          ],
        ),),
      ));


  }
}
