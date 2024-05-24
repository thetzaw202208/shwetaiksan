import 'package:dio/dio.dart';
import 'package:shwetaiksan/constants/api.dart';
import 'package:shwetaiksan/network/response_vo/register_response_vo.dart';

import '../../api/api_service.dart';
import 'login_data_agent.dart';

class LoginDataAgentImpl extends LoginDataAgent {
  late ApiService _api;

  static final LoginDataAgentImpl _singleton =
  LoginDataAgentImpl._internal();

  factory LoginDataAgentImpl() {
    return _singleton;
  }

  LoginDataAgentImpl._internal() {
    final dio = Dio();
    _api = ApiService(dio,baseUrl: baseURL);
  }

  @override
  Future<RegisterVo> loginUser(String phone, String password) {
   return _api.loginUser(phone, password);
  }







}