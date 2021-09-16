import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiUtils {
  static String baseUrl = "http://localhost:3000/api/v1";

  static Future<http.Response> signup({
    String? username,
    String? email,
    String? password,
  }) async {
    return await http.post(
      Uri.parse(baseUrl + "/auth/register"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          "username": username,
          "email": email,
          "password": password,
          "from": kIsWeb ? "web" : "mobile"
        },
      ),
    );
  }

  static Future<http.Response> login({
    String? username,
    String? password,
  }) async {
    return await http.post(
      Uri.parse(baseUrl + "/auth/login"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {"username": username, "password": password},
      ),
    );
  }
}
