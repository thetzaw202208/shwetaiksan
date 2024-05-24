import 'package:dio/dio.dart';
import 'package:shwetaiksan/constants/api.dart';
import 'package:shwetaiksan/network/data_agent/live/live_data_agent.dart';
import 'package:shwetaiksan/network/response_vo/live_data_response_vo.dart';

import '../../api/api_service.dart';

class LiveDataAgentImpl extends LiveDataAgent {
  late ApiService _api;

  static final LiveDataAgentImpl _singleton =
  LiveDataAgentImpl._internal();

  factory LiveDataAgentImpl() {
    return _singleton;
  }

  LiveDataAgentImpl._internal() {
    final dio = Dio(BaseOptions(headers: <String, String>{
      'Content-Type': contentType,

    }));
    _api = ApiService(dio,baseUrl: twoURL);
  }

  @override
  Future<LiveResultApiResponse> getLiveData() => _api.live();



}