import 'package:shwetaiksan/network/response_vo/register_response_vo.dart';

abstract class LoginDataAgent {
  Future<RegisterVo> loginUser(String phone,String password);
}
