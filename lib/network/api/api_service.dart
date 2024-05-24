import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:retrofit/http.dart';
import 'package:shwetaiksan/network/response_vo/get_balance_response_vo.dart';
import 'package:shwetaiksan/network/response_vo/live_data_response_vo.dart';
import 'package:shwetaiksan/network/response_vo/register_response_vo.dart';
import 'package:shwetaiksan/network/response_vo/result_data_response_vo.dart';
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

  @POST(register)
  @FormUrlEncoded()
  Future<RegisterVo> registerUser(
    @Field('name') String name,
    @Field('phone') String phone,
    @Field('password') String password,
  );

  @POST(login)
  @FormUrlEncoded()
  Future<RegisterVo> loginUser(

      @Field('phone') String phone,
      @Field('password') String password,
      );

  @POST(getBalance)
  @FormUrlEncoded()
  Future<GetBalanceResponseVo> getUserBalance(

      @Field('phone') String phone,

      );
}
