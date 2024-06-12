import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:shwetaiksan/network/response_vo/get_balance_response_vo.dart';
import 'package:shwetaiksan/network/response_vo/history_response_vo.dart';
import 'package:shwetaiksan/network/response_vo/live_data_response_vo.dart';
import 'package:shwetaiksan/network/response_vo/register_response_vo.dart';
import 'package:shwetaiksan/network/response_vo/result_data_response_vo.dart';
import 'package:shwetaiksan/network/response_vo/two_d_order_am_response_vo.dart';
import '../../constants/api.dart';
part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  ///Result
  @GET(resultEndpoint)
  Future<TwoResultApiResponse> getResult();

  ///Live
  @GET(liveEndpoint)
  Future<LiveResultApiResponse> live();

  ///register

  @POST(registerEndPoint)
  @FormUrlEncoded()
  Future<RegisterVo> registerUser(
    @Field('name') String name,
    @Field('phone') String phone,
    @Field('password') String password,
  );

  ///login
  @POST(loginEndPoint)
  @FormUrlEncoded()
  Future<RegisterVo> loginUser(

      @Field('phone') String phone,
      @Field('password') String password,
      );


  ///get balance
  @POST(getBalanceEndPoint)
  @FormUrlEncoded()
  Future<GetBalanceResponseVo> getUserBalance(

      @Field('phone') String phone,

      );

  //twoDOrder
  @POST(twoDOrderAmEndPoint)

  Future<TwoDOrderAmResponseVo> twoDOrderAm(

      @Field('phone') String phone,
      @Field('amount') List<int> amount,
      @Field('number') List<int> number,
      @Field('date') String date,
      @Field('type') String type,
      @Field('isIncome') int isIncome,
      );


  ///History
  @POST(historyEndPoint)
  @FormUrlEncoded()
  Future<HistoryResponseVo> getHistory(

      @Field('phone') String phone,
      @Field('date') String date,
      );
}
