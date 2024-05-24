import 'package:dio/dio.dart';
import 'package:shwetaiksan/constants/api.dart';
import 'package:shwetaiksan/network/data_agent/get_balance/get_balance_data_agent.dart';
import 'package:shwetaiksan/network/response_vo/get_balance_response_vo.dart';

import '../../api/api_service.dart';

class GetBalanceDataAgentImpl extends GetBalanceDataAgent {
  late ApiService _api;

  static final GetBalanceDataAgentImpl _singleton =
  GetBalanceDataAgentImpl._internal();

  factory GetBalanceDataAgentImpl() {
    return _singleton;
  }

  GetBalanceDataAgentImpl._internal() {
    final dio = Dio();
    _api = ApiService(dio,baseUrl: baseURL);
  }

  @override
  Future<GetBalanceResponseVo> getUserBalance(String phone) {
    return _api.getUserBalance(phone);
  }







}