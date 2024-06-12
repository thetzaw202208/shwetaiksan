import 'package:flutter_dotenv/flutter_dotenv.dart';

///Base URL
String baseURL = dotenv.get("baseURL", fallback: null);
String twoURL = dotenv.get("twoURL", fallback: null);
///Endpoint
///register="register.php"
// 2dResult="2d_result"
// live="live"
const String resultEndpoint = "2d_result";
const String liveEndpoint = "live";
const String registerEndPoint="register.php";
const String loginEndPoint="login.php";
const String getBalanceEndPoint="get_balance.php";
const String twoDOrderAmEndPoint="two_d_record_am.php";
const String twoDOrderPmEndPoint="two_d_record_pm.php";
const String historyEndPoint="history_data.php";

///Authorization token
String authorizationToken =dotenv.get("API_TOKEN", fallback: null);

const String contentType = 'application/json';