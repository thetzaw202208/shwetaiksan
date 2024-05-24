import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shwetaiksan/screens/3d/three_d_details_screen.dart';
import 'package:shwetaiksan/utils/screen_extension.dart';

import '../network/static_vo/number_and_amount_vo.dart';
import '../screens/2d/details_screen.dart';

class ThreeDProvider extends ChangeNotifier{
  var items = [];
  TextEditingController amount=TextEditingController();
  List<int> selectedNumber = [];

  List<NumberAndAmount> orderList=[];
  int totalAmount=0;
  ThreeDProvider() {
    for (var i = 0; i < 1000; i++) {
      items.add(i);
    }
    notifyListeners();
  }

  selectNumbers(int index) {
    if (selectedNumber.contains(index)) {
      selectedNumber.remove(index);
    } else {
      selectedNumber.add(index);
    }
    notifyListeners();
  }

  twoDOrder(int amount,BuildContext context){
    totalAmount=amount*selectedNumber.length;
    orderList.clear();
    for(var i=0;i<selectedNumber.length;i++){

        orderList.add(NumberAndAmount(selectedNumber[i], amount));


    }

    context.navigateAndRemoveUntil(const ThreeDDetailsScreen(),true);
    notifyListeners();
  }
}