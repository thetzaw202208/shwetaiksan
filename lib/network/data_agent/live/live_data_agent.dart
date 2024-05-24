import 'package:shwetaiksan/network/response_vo/live_data_response_vo.dart';

abstract class LiveDataAgent {
  Future<LiveResultApiResponse> getLiveData();
}
