import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shwetaiksan/network/data_agent/two_d_order_am/two_d_order_am_data_agent.dart';
import 'package:shwetaiksan/network/data_agent/two_d_order_am/two_d_order_data_agent_impl.dart';
import 'package:shwetaiksan/network/static_vo/number_and_amount_vo.dart';
import 'package:shwetaiksan/screens/2d/details_screen.dart';
import 'package:shwetaiksan/screens/history/history.dart';
import 'package:shwetaiksan/utils/screen_extension.dart';

import '../generated/locale_keys.g.dart';
import '../screens/home/home_screen.dart';

class TwoDProvider extends ChangeNotifier {
  var items = [];
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  TextEditingController amount = TextEditingController();
  TwoDOrderAmDataAgent twoDOrderAmDataAgent = TwoDOrderAmDataAgentImpl();
  bool isLoading = false;
  bool isSelect = false;
  bool isPrefix = false;
  bool isSuffix = false;
  bool isPower = false;
  bool isNK = false;
  bool isPT = false;
  bool isZeroPrefix = false;
  bool isZeroSuffix = false;
  List<int> selectedNumber = [];
  List<NumberAndAmount> orderList = [];
  List<String> readyMadeTitle = [
    "အပူး",
    "ထိပ်",
    "ပိတ်",
    "ပါဝါ",
    "နက္ခတ်",
    "ပတ်သီး"
  ];
  int? selectedPrefixNumber;
  int? selectedSuffixNumber;
  int? selectedPTNumber;
  int? selectedReadyMade;
  bool selectedRM = false;

  int totalAmount = 0;

  List<int> coupleList = [00, 11, 22, 33, 44, 55, 66, 77, 88, 99];
  List<int> zeroOpenList = [00, 01, 02, 03, 04, 05, 06, 07, 08, 09];
  List<int> zeroCloseList = [00, 10, 20, 30, 40, 50, 60, 70, 80, 90];

  List<int> oneOpenList = [10, 11, 12, 13, 14, 15, 16, 17, 18, 19];
  List<int> oneCloseList = [00, 11, 21, 31, 41, 51, 61, 71, 81, 91];

  List<int> twoOpenList = [20, 21, 22, 23, 24, 25, 26, 27, 28, 29];
  List<int> twoCloseList = [02, 12, 22, 32, 42, 52, 62, 72, 82, 92];

  List<int> threeOpenList = [30, 31, 32, 33, 34, 35, 36, 37, 38, 39];
  List<int> threeCloseList = [03, 13, 23, 33, 43, 53, 63, 73, 83, 93];

  List<int> fourOpenList = [40, 41, 42, 43, 44, 45, 46, 47, 48, 49];
  List<int> fourCloseList = [04, 14, 24, 34, 44, 54, 64, 74, 84, 94];

  List<int> fiveOpenList = [50, 51, 52, 53, 54, 55, 56, 57, 58, 59];
  List<int> fiveCloseList = [05, 15, 25, 35, 45, 55, 65, 75, 85, 95];

  List<int> sixOpenList = [60, 61, 62, 63, 64, 65, 66, 67, 68, 69];
  List<int> sixCloseList = [06, 16, 26, 36, 46, 56, 66, 76, 86, 96];

  List<int> sevenOpenList = [70, 71, 72, 73, 74, 75, 76, 77, 78, 79];
  List<int> sevenCloseList = [07, 17, 27, 37, 47, 57, 67, 77, 87, 97];

  List<int> eightOpenList = [80, 81, 82, 83, 84, 85, 86, 87, 88, 89];
  List<int> eightCloseList = [08, 18, 28, 38, 48, 58, 68, 78, 88, 98];

  List<int> nineOpenList = [90, 91, 92, 93, 94, 95, 96, 97, 98, 99];
  List<int> nineCloseList = [09, 19, 29, 39, 49, 59, 69, 79, 89, 99];

  List<int> powerList = [05, 50, 16, 61, 27, 72, 28, 93, 49, 94];

  List<int> natKhetList = [07, 70, 18, 81, 35, 53, 42, 24, 69, 96];

  List<int> zeroPT = [
    00,
    01,
    02,
    03,
    04,
    05,
    06,
    07,
    08,
    09,
    10,
    20,
    30,
    40,
    50,
    60,
    70,
    80,
    90
  ];
  List<int> onePT = [
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    00,
    21,
    31,
    41,
    51,
    61,
    71,
    81,
    91
  ];
  List<int> twoPT = [
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    02,
    12,
    32,
    42,
    52,
    62,
    72,
    82,
    92
  ];
  List<int> threePT = [
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    03,
    13,
    23,
    43,
    53,
    63,
    73,
    83,
    93
  ];
  List<int> fourPT = [
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    04,
    14,
    24,
    34,
    54,
    64,
    74,
    84,
    94
  ];
  List<int> fivePT = [
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    05,
    15,
    25,
    35,
    45,
    65,
    75,
    85,
    95
  ];
  List<int> sixPT = [
    60,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    06,
    16,
    26,
    36,
    46,
    56,
    76,
    86,
    96
  ];
  List<int> sevenPT = [
    70,
    71,
    72,
    73,
    74,
    75,
    76,
    77,
    78,
    79,
    07,
    17,
    27,
    37,
    47,
    57,
    67,
    87,
    97
  ];
  List<int> eightPT = [
    80,
    81,
    82,
    83,
    84,
    85,
    86,
    87,
    88,
    89,
    08,
    18,
    28,
    38,
    48,
    58,
    68,
    78,
    98
  ];
  List<int> ninePT = [
    90,
    91,
    92,
    93,
    94,
    95,
    96,
    97,
    98,
    99,
    09,
    19,
    29,
    39,
    49,
    59,
    69,
    79,
    89
  ];

  enableLoading() {
    isLoading = true;
    notifyListeners();
  }

  disableLoading() {
    isLoading = false;
    notifyListeners();
  }

  TwoDProvider() {
    for (var i = 0; i < 100; i++) {
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

  selectedCouple() {
    selectedNumber.clear();
    isSelect = !isSelect;
    isZeroPrefix = false;
    isZeroSuffix = false;
    if (isSelect) {
      for (var i = 0; i < coupleList.length; i++) {
        selectedNumber.add(coupleList[i]);
        notifyListeners();
      }
    } else {
      selectedNumber.clear();
      notifyListeners();
    }
    notifyListeners();
  }

  showHidePrefix() {
    isPrefix = !isPrefix;
    notifyListeners();
  }

  showHideSuffix() {
    isSuffix = !isSuffix;
    notifyListeners();
  }

  twoDOrder(int amount, BuildContext context) {
    totalAmount = amount * selectedNumber.length;
    for (var i = 0; i < selectedNumber.length; i++) {
      orderList.add(NumberAndAmount(selectedNumber[i], amount));
    }

    context.navigateAndRemoveUntil(const TwoDDetailsScreen(), true);
    notifyListeners();
  }

  twoDRequest(BuildContext context) async {
    List<int> amountList = [];
    SharedPreferences sh = await SharedPreferences.getInstance();
    var phone = sh.getString("phone") ?? "";
    for (var i = 0; i < orderList.length; i++) {
      amountList.add(orderList[i].amount);
    }
    notifyListeners();
    var month = "";
    if (DateTime.now().month.toString().length == 1) {
      month = "0${DateTime.now().month}";
    } else {
      month = "${DateTime.now().month}";
    }

    var date = "${DateTime.now().year}-$month-${DateTime.now().day}";
    print("Order request: ${amountList.toString()}");
    var type = "2D Betting";
    twoDOrderAmDataAgent
        .twoDOrderAm(phone, amountList, selectedNumber, date,type, 0)
        .then((value) {
      if (value.code == 200) {
        print("Order Success");
        disableLoading();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: LocaleKeys.kCongratulations.tr(),
          desc: LocaleKeys.kSuccessTransaction.tr(),
          btnCancelText: LocaleKeys.kHistory.tr(),
          btnOkText: LocaleKeys.KHome.tr(),
          btnCancelOnPress: () {
            context.navigateAndRemoveUntil(const HistoryScreen(), false);
          },
          btnOkOnPress: () {
            context.navigateAndRemoveUntil(const MyHomePage(), false);
          },
        ).show();
        clearData();
      }else{
        disableLoading();
        notifyListeners();
      }
    }).catchError((error) {
      disableLoading();
      notifyListeners();
      print("Order Error");
      print(error.toString());
    });
    print("Order List: $orderList");
  }

  clearData() {
    selectedNumber.clear();
    orderList.clear();
    amount.clear();
    notifyListeners();
  }

  selectReadyMade(int index) {
    selectedReadyMade = index;
    selectedRM = !selectedRM;
    selectedSuffixNumber = null;
    selectedPTNumber = null;
    selectedPrefixNumber = null;
    switch (index) {
      case 0:
        selectedCouple();
      case 1:
        showHidePrefix();
      case 2:
        showHidePrefix();
      case 3:
        selectPower();
      case 4:
        selectNatKhet();
      case 5:
        showHidePrefix();
    }
    notifyListeners();
  }

  selectPower() {
    selectedNumber.clear();
    for (var i = 0; i < powerList.length; i++) {
      selectedNumber.add(powerList[i]);
      notifyListeners();
    }
  }

  selectNatKhet() {
    selectedNumber.clear();
    for (var i = 0; i < natKhetList.length; i++) {
      selectedNumber.add(natKhetList[i]);
      notifyListeners();
    }
  }

  selectPrefix(int number) {
    selectedNumber.clear();
    selectedSuffixNumber = null;
    selectedPTNumber = null;
    selectedPrefixNumber = number;
    switch (number) {
      case 0:
        for (var i = 0; i < zeroOpenList.length; i++) {
          selectedNumber.add(zeroOpenList[i]);
          notifyListeners();
        }

      case 1:
        for (var i = 0; i < oneOpenList.length; i++) {
          selectedNumber.add(oneOpenList[i]);
          notifyListeners();
        }
      case 2:
        for (var i = 0; i < twoOpenList.length; i++) {
          selectedNumber.add(twoOpenList[i]);
          notifyListeners();
        }
      case 3:
        for (var i = 0; i < threeOpenList.length; i++) {
          selectedNumber.add(threeOpenList[i]);
          notifyListeners();
        }
      case 4:
        for (var i = 0; i < fourOpenList.length; i++) {
          selectedNumber.add(fourOpenList[i]);
          notifyListeners();
        }
      case 5:
        for (var i = 0; i < fiveOpenList.length; i++) {
          selectedNumber.add(fiveOpenList[i]);
          notifyListeners();
        }
      case 6:
        for (var i = 0; i < sixOpenList.length; i++) {
          selectedNumber.add(sixOpenList[i]);
          notifyListeners();
        }
      case 7:
        for (var i = 0; i < sevenOpenList.length; i++) {
          selectedNumber.add(sevenOpenList[i]);
          notifyListeners();
        }
      case 8:
        for (var i = 0; i < eightOpenList.length; i++) {
          selectedNumber.add(eightOpenList[i]);
          notifyListeners();
        }
      case 9:
        for (var i = 0; i < nineOpenList.length; i++) {
          selectedNumber.add(nineOpenList[i]);
          notifyListeners();
        }
    }

    notifyListeners();
  }

  selectPT(number) {
    selectedNumber.clear();
    selectedPrefixNumber = null;
    selectedSuffixNumber = null;
    selectedPTNumber = number;
    switch (number) {
      case 0:
        for (var i = 0; i < zeroPT.length; i++) {
          selectedNumber.add(zeroPT[i]);
          notifyListeners();
        }

      case 1:
        for (var i = 0; i < onePT.length; i++) {
          selectedNumber.add(onePT[i]);
          notifyListeners();
        }
      case 2:
        for (var i = 0; i < twoPT.length; i++) {
          selectedNumber.add(twoPT[i]);
          notifyListeners();
        }
      case 3:
        for (var i = 0; i < threePT.length; i++) {
          selectedNumber.add(threePT[i]);
          notifyListeners();
        }
      case 4:
        for (var i = 0; i < fourPT.length; i++) {
          selectedNumber.add(fourPT[i]);
          notifyListeners();
        }
      case 5:
        for (var i = 0; i < fivePT.length; i++) {
          selectedNumber.add(fivePT[i]);
          notifyListeners();
        }
      case 6:
        for (var i = 0; i < sixPT.length; i++) {
          selectedNumber.add(sixPT[i]);
          notifyListeners();
        }
      case 7:
        for (var i = 0; i < sevenPT.length; i++) {
          selectedNumber.add(sevenPT[i]);
          notifyListeners();
        }
      case 8:
        for (var i = 0; i < eightPT.length; i++) {
          selectedNumber.add(eightPT[i]);
          notifyListeners();
        }
      case 9:
        for (var i = 0; i < ninePT.length; i++) {
          selectedNumber.add(ninePT[i]);
          notifyListeners();
        }
    }

    notifyListeners();
  }

  selectSuffix(int number) {
    selectedNumber.clear();
    selectedPrefixNumber = null;
    selectedPTNumber = null;
    selectedSuffixNumber = number;
    switch (number) {
      case 0:
        for (var i = 0; i < zeroCloseList.length; i++) {
          selectedNumber.add(zeroCloseList[i]);
          notifyListeners();
        }

      case 1:
        for (var i = 0; i < oneCloseList.length; i++) {
          selectedNumber.add(oneCloseList[i]);
          notifyListeners();
        }
      case 2:
        for (var i = 0; i < twoCloseList.length; i++) {
          selectedNumber.add(twoCloseList[i]);
          notifyListeners();
        }
      case 3:
        for (var i = 0; i < threeCloseList.length; i++) {
          selectedNumber.add(threeCloseList[i]);
          notifyListeners();
        }
      case 4:
        for (var i = 0; i < fourCloseList.length; i++) {
          selectedNumber.add(fourCloseList[i]);
          notifyListeners();
        }
      case 5:
        for (var i = 0; i < fiveCloseList.length; i++) {
          selectedNumber.add(fiveCloseList[i]);
          notifyListeners();
        }
      case 6:
        for (var i = 0; i < sixCloseList.length; i++) {
          selectedNumber.add(sixCloseList[i]);
          notifyListeners();
        }
      case 7:
        for (var i = 0; i < sevenCloseList.length; i++) {
          selectedNumber.add(sevenCloseList[i]);
          notifyListeners();
        }
      case 8:
        for (var i = 0; i < eightCloseList.length; i++) {
          selectedNumber.add(eightCloseList[i]);
          notifyListeners();
        }
      case 9:
        for (var i = 0; i < nineCloseList.length; i++) {
          selectedNumber.add(nineCloseList[i]);
          notifyListeners();
        }
    }

    notifyListeners();
  }
}
