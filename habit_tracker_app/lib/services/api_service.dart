import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:habit_trackerapp/models/user/user_info_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = "https://app-250519224610.azurewebsites.net/api";




  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('user');
    if (json == null) return null;
    final user = UserInfoDto.fromJson(jsonDecode(json));
    return user.token;
  }

  Future<http.Response?> get(String endpoint) async {
    final token = await _getToken();
    if (token == null) return null;

    final res = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Authorization': 'Bearer $token'},
    );

    return res;
  }

  Future<http.Response?> post(String endpoint, Map<String, dynamic> data) async {
    final token = await _getToken();
    if (token == null) return null;

    final res = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    return res;
  }

  Future<http.Response?> put(String endpoint, Map<String, dynamic> data) async {
    final token = await _getToken();
    if (token == null) return null;

    final res = await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    return res;
  }

  Future<http.Response?> delete(String endpoint) async {
    final token = await _getToken();
    if (token == null) return null;

    final res = await http.delete(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Authorization': 'Bearer $token'},
    );

    return res;
  }
}
