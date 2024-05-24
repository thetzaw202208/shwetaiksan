import 'package:shwetaiksan/network/response_vo/register_response_vo.dart';

abstract class RegisterDataAgent {
  Future<RegisterVo> registerUser(String name,String phone,String password);
}
