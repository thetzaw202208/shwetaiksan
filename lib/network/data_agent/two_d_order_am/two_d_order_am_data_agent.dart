
import 'package:shwetaiksan/network/response_vo/two_d_order_am_response_vo.dart';

abstract class TwoDOrderAmDataAgent {
  Future<TwoDOrderAmResponseVo> twoDOrderAm(String phone,List<int> amount,List<int> number,String date,String type,int isIncome);
}
