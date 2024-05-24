
import 'package:shwetaiksan/network/response_vo/result_data_response_vo.dart';

abstract class ResultDataAgent {
  Future<TwoResultApiResponse> getResultData();
}
