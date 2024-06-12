import 'package:dio/dio.dart';
import 'package:shwetaiksan/constants/api.dart';
import 'package:shwetaiksan/network/response_vo/history_response_vo.dart';

import '../../api/api_service.dart';
import 'history_data_agent.dart';

class HistoryDataAgentImpl extends HistoryDataAgent {
  late ApiService _api;

  static final HistoryDataAgentImpl _singleton =
  HistoryDataAgentImpl._internal();

  factory HistoryDataAgentImpl() {
    return _singleton;
  }

  HistoryDataAgentImpl._internal() {
    final dio = Dio();
    _api = ApiService(dio,baseUrl: baseURL);
  }

  @override
  Future<HistoryResponseVo> getHistory(String phone, String date) {
    return _api.getHistory(phone,date);
  }



}