import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shwetaiksan/constants/color_const.dart';
import 'package:shwetaiksan/generated/locale_keys.g.dart';
import 'package:shwetaiksan/network/response_vo/history_response_vo.dart';
import 'package:shwetaiksan/provider/history_provider.dart';

import '../../constants/font.dart';

class SampleHistoryData {
  String type;
  String title;
  int status;
  String date;
  String amount;

  SampleHistoryData(this.type, this.title, this.status, this.date, this.amount);
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<SampleHistoryData> data = [
      SampleHistoryData("2 D", "2 D Winner prize", 1, "2024-05-25", "2060000"),
      SampleHistoryData("2 D", "2 D Order", 2, "2024-05-25", "50000"),
      SampleHistoryData("3 D", "3 D Winner prize", 1, "2024-05-16", "30500000"),
      SampleHistoryData("3 D", "3 D Order", 2, "2024-05-06", "2000000"),
      SampleHistoryData("SP", "Spin", 1, "2024-05-06", "5000"),
    ];
    return ChangeNotifierProvider<HistoryProvider>(
      create: (context) => HistoryProvider(),
      child: Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          // title: Text(
          //   LocaleKeys.kHistory.tr(),
          //   style: appBarTextStyle,
          // ),
          actions: [
            Consumer<HistoryProvider>(
              builder: (context, provider, child) =>  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Chip(
                  backgroundColor: Colors.blue.withOpacity(0.5),
                  elevation: 10,
                  side: BorderSide.none,
                  label: Text(
                    provider.dateShow,
                    style: paymentLabelTextStyle,
                  ),
                  deleteIcon: const Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: whiteColor,
                  ),
                  onDeleted: () {

                    provider.selectDate(context);
                  },
                ),
              ),
            )
          ],
        ),
        body: Consumer<HistoryProvider>(
          builder: (context, provider, child) {
            return provider.isLoading?SizedBox(
                height: MediaQuery.of(context).size.height * .8,
                child: const Center(child: CircularProgressIndicator(color: errorColor,),)):  provider.historyDataList?.isEmpty==true && provider.noData==true
                ? SizedBox(
              height: MediaQuery.of(context).size.height * .8,
                  child: Center(
                      child: Text(
                      LocaleKeys.kNoData.tr(),
                      style: labelSmallTextStyle,
                    )),
                )
                : _buildListView(data: provider.historyDataList);
          },
        ),
      ),
    );
  }
}

class _buildListView extends StatelessWidget {
  const _buildListView({
    super.key,
    required this.data,
  });

  final List<HistoryData>? data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (data?.length??1) * MediaQuery.of(context).size.height ,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              child: ListTile(
                // leading: Container(
                //   width: 35,
                //     height: 35,
                //
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color:errorColor,
                //
                //     ),
                //     child: Center(child: Text(data?[index].type??"",style: leadingTextStyle,))),

                title: Text(
                  data?[index].type ?? "",
                  style: appBarTextStyle,
                ),
                subtitle: Text(
                  "${data?[index].date.toString().split(" ")[0]}",
                  style: labelSmallTextStyle,
                ),
                trailing: Text(
                    data?[index].isIncome == 1
                        ? "+${data?[index].amount} MMK"
                        : "-${data?[index].amount} MMK",
                    style: data?[index].isIncome == 1
                        ? incomeTextStyle
                        : outComeTextStyle),
              ),
            ),
          );
        },
        itemCount: data?.length,
      ),
    );
  }
}
