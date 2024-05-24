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
const String register="register.php";
const String login="login.php";
const String getBalance="get_balance.php";

///Authorization token
String authorizationToken =dotenv.get("API_TOKEN", fallback: null);

const String contentType = 'application/json';