import 'package:dio/dio.dart';
import 'package:shwetaiksan/constants/api.dart';
import 'package:shwetaiksan/network/data_agent/live/live_data_agent.dart';
import 'package:shwetaiksan/network/data_agent/register/register_data_agent.dart';
import 'package:shwetaiksan/network/response_vo/live_data_response_vo.dart';
import 'package:shwetaiksan/network/response_vo/register_response_vo.dart';

import '../../api/api_service.dart';

class RegisterDataAgentImpl extends RegisterDataAgent {
  late ApiService _api;

  static final RegisterDataAgentImpl _singleton =
  RegisterDataAgentImpl._internal();

  factory RegisterDataAgentImpl() {
    return _singleton;
  }

  RegisterDataAgentImpl._internal() {
    final dio = Dio();
    _api = ApiService(dio,baseUrl: baseURL);
  }

  @override
  Future<RegisterVo> registerUser(String name, String phone, String password) {
   return _api.registerUser(name, phone, password);
  }





}