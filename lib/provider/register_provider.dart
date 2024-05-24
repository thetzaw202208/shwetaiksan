import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shwetaiksan/constants/color_const.dart';
import 'package:shwetaiksan/screens/home/home_screen.dart';
import 'package:shwetaiksan/utils/screen_extension.dart';

import '../network/data_agent/register/register_data_agent.dart';
import '../network/data_agent/register/register_data_agnet_impl.dart';

class RegisterProvider extends ChangeNotifier{
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController password=TextEditingController();
  Color buttonColor = Colors.grey.withOpacity(0.5);
  bool isLoading=false;
  bool isVisible=false;
  RegisterDataAgent _registerDataAgent=RegisterDataAgentImpl();

  RegisterProvider(){
    notifyListeners();
  }

  enableLoading(){
    isLoading=true;
    notifyListeners();
  }
  disableLoading(){
    isLoading=false;
    notifyListeners();
  }
  updatePhoneText(String phoneText){
    phone.text=phoneText;
    notifyListeners();
  }
  visibilityOnOff(){
    isVisible=!isVisible;
    notifyListeners();
  }
registerUser(String name,String phone,String password,BuildContext context){
    print("Here is request data $name $phone $password");
    _registerDataAgent.registerUser(name, phone, password).then((value){
      if(value.code==200){
        print("Here is data ${value.data?.phone}");
        disableLoading();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'ဂုဏ်ယူပါတယ်',
          desc: 'လုပ်ဆောင်မှု အောင်မြင်ပါသည်',
          
          btnOkText: "ဝင်မည်",
         
          btnOkOnPress: () {
            context.navigateAndRemoveUntil(
                const MyHomePage(), true);
          },
        ).show();
        notifyListeners();
      }else if(value.code==201){
        disableLoading();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'ဝမ်းနည်းပါတယ်',
          desc: 'ယခုနံပါတ်ဖြင့် အကောင့်ဖွင့်ထားပြီးဖြစ်ပါသည်',

          btnOkText: "အိုကေ",

          btnOkOnPress: () {
            context.navigateAndRemoveUntil(
                const MyHomePage(), true);
          },
        ).show();
        notifyListeners();
      }
    });
}

  void updateButtonColor() {
    if (name.text.isEmpty||phone.text.isEmpty||password.text.isEmpty||isLoading) {
      buttonColor = Colors.grey.withOpacity(0.5);
    } else {
      buttonColor = blackColor; // Set your desired color here
    }
    notifyListeners();
  }
}