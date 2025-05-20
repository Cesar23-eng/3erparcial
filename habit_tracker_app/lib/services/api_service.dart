import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user/user_info_dto.dart';
import '../models/user/user_login_dto.dart';
import '../models/user/user_register_dto.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  ApiService._internal();

  final String _baseUrl = "https://app-250520095308.azurewebsites.net/api";
  UserInfoDto? _currentUser;

  // Getter del usuario actual en memoria
  UserInfoDto? get currentUser => _currentUser;

  // Token y headers
  Future<String?> _getToken() async {
    if (_currentUser != null) return _currentUser!.token;

    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('user');
    if (json == null) return null;

    _currentUser = UserInfoDto.fromJson(jsonDecode(json));
    return _currentUser!.token;
  }

  Future<Map<String, String>> _getHeaders({bool withAuth = true}) async {
    final headers = {'Content-Type': 'application/json'};
    if (withAuth) {
      final token = await _getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  // Auth: login
  Future<UserInfoDto?> login(UserLoginDto dto) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/auth/login"),
        headers: await _getHeaders(withAuth: false),
        body: jsonEncode(dto.toJson()),
      );

      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        final user = UserInfoDto.fromJson(json);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(user.toJson()));
        _currentUser = user;

        return user;
      }

      print("❌ Login fallido: ${res.body}");
      return null;
    } catch (e) {
      print("❌ Error login: $e");
      return null;
    }
  }

  // Auth: register
  Future<bool> register(UserRegisterDto dto) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/auth/register"),
        headers: await _getHeaders(withAuth: false),
        body: jsonEncode(dto.toJson()),
      );

      if (res.statusCode == 200) return true;

      if (res.body.isNotEmpty) {
        print("❌ Registro fallido: ${res.body}");
      }

      return false;
    } catch (e) {
      print("❌ Error register: $e");
      return false;
    }
  }

  // Auth: logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    _currentUser = null;
  }

  // GET con token
  Future<http.Response?> get(String endpoint) async {
    final headers = await _getHeaders();
    return http.get(Uri.parse("$_baseUrl/$endpoint"), headers: headers);
  }

  // POST con token
  Future<http.Response?> post(String endpoint, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    return http.post(
      Uri.parse("$_baseUrl/$endpoint"),
      headers: headers,
      body: jsonEncode(data),
    );
  }

  // PUT con token
  Future<http.Response?> put(String endpoint, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    return http.put(
      Uri.parse("$_baseUrl/$endpoint"),
      headers: headers,
      body: jsonEncode(data),
    );
  }

  // DELETE con token
  Future<http.Response?> delete(String endpoint) async {
    final headers = await _getHeaders();
    return http.delete(
      Uri.parse("$_baseUrl/$endpoint"),
      headers: headers,
    );
  }
}
