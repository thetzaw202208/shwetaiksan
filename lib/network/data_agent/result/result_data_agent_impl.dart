import 'package:dio/dio.dart';
import 'package:shwetaiksan/constants/api.dart';
import 'package:shwetaiksan/network/data_agent/result/result_data_agent.dart';
import 'package:shwetaiksan/network/response_vo/result_data_response_vo.dart';

import '../../api/api_service.dart';

class ResultDataAgentImpl extends ResultDataAgent {
  late ApiService _api;

  static final ResultDataAgentImpl _singleton =
  ResultDataAgentImpl._internal();

  factory ResultDataAgentImpl() {
    return _singleton;
  }

  ResultDataAgentImpl._internal() {
    final dio = Dio(BaseOptions(headers: <String, String>{
      'Content-Type': contentType,

    }));
    _api = ApiService(dio,baseUrl: twoURL);
  }

  @override
  Future<TwoResultApiResponse> getResultData() => _api.getResult();



}