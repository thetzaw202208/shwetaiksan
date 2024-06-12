
import 'package:shwetaiksan/network/response_vo/history_response_vo.dart';

abstract class HistoryDataAgent {
  Future<HistoryResponseVo> getHistory(String phone,String date);
}
