import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shwetaiksan/network/data_agent/history/history_data_agent.dart';
import 'package:shwetaiksan/network/data_agent/history/history_data_agent_impl.dart';
import 'package:shwetaiksan/network/response_vo/history_response_vo.dart';

class HistoryProvider extends ChangeNotifier{
 HistoryDataAgent historyDataAgent=HistoryDataAgentImpl();
 List<HistoryData>? historyDataList;
 String dateShow = "";
 String dayName = "";
bool isLoading=false;
bool noData=true;
 DateTime? selectedDate;
 var month = "",date="";
 HistoryProvider(){
   historyDataList=[];
   enableLoading();
   if (DateTime.now().month.toString().length == 1) {
     month = "0${DateTime.now().month}";
   } else {
     month = "${DateTime.now().month}";
   }
    date = "${DateTime.now().year}-$month-${DateTime.now().day}";
   if (dateShow == "") {
     dateShow = date;
     getHistoryData(dateShow);
     notifyListeners();
   } else {
     getHistoryData(dateShow);
     notifyListeners();
   }
     getHistoryData(date);
 }
 enableLoading() {
   isLoading = true;
   notifyListeners();
 }

 disableLoading() {
   isLoading = false;
   notifyListeners();
 }

 ///date select
 Future<void> selectDate(BuildContext context) async {
   print("Date select work");
   final DateTime? picked = await showDatePicker(
     context: context,
     initialDate: DateTime.now(),
     firstDate: DateTime(2024, 1),
     lastDate: DateTime.now(),
   );

   if (picked != null && picked != selectedDate) {
     selectedDate = picked;
     dateShow = selectedDate.toString().split(" ")[0];
     enableLoading();
     Future.delayed(Duration(seconds: 1),(){
       getHistoryData(dateShow);
     });

     dayName = selectedDate == null
         ? 'No date selected'
         : DateFormat('EEEE').format(selectedDate!);

     notifyListeners();
   }
 }
 getHistoryData(String date) async{

   SharedPreferences sh=await SharedPreferences.getInstance();
   var phone=sh.getString("phone")??"";

   return await historyDataAgent.getHistory(phone, date).then((value) {
     if(value.code==200){
       historyDataList=value.data;
       noData=false;
       disableLoading();
       notifyListeners();
     }else{
       historyDataList=value.data;
       noData=true;
       disableLoading();
       notifyListeners();
     }
   });
 }
}