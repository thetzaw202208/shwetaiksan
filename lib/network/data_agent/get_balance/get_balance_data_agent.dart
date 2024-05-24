import 'package:shwetaiksan/network/response_vo/get_balance_response_vo.dart';

abstract class GetBalanceDataAgent {
  Future<GetBalanceResponseVo> getUserBalance(String phone);
}
