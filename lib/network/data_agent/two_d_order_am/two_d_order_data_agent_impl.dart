import 'package:dio/dio.dart';
import 'package:shwetaiksan/constants/api.dart';
import 'package:shwetaiksan/network/data_agent/two_d_order_am/two_d_order_am_data_agent.dart';
import 'package:shwetaiksan/network/response_vo/register_response_vo.dart';
import 'package:shwetaiksan/network/response_vo/two_d_order_am_response_vo.dart';

import '../../api/api_service.dart';

class TwoDOrderAmDataAgentImpl extends TwoDOrderAmDataAgent {
  late ApiService _api;

  static final TwoDOrderAmDataAgentImpl _singleton =
  TwoDOrderAmDataAgentImpl._internal();

  factory TwoDOrderAmDataAgentImpl() {
    return _singleton;
  }

  TwoDOrderAmDataAgentImpl._internal() {
    final dio = Dio(BaseOptions(headers: <String, String>{
      'Content-Type': contentType,

    }));
    _api = ApiService(dio,baseUrl: baseURL);
  }

  @override
  Future<TwoDOrderAmResponseVo> twoDOrderAm(String phone, List<int> amount, List<int> number, String date, String type, int isIncome) {
   return _api.twoDOrderAm(phone, amount, number, date, type, isIncome);
  }


}