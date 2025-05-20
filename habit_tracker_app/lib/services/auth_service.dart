import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user/user_info_dto.dart';
import '../models/user/user_login_dto.dart';
import '../models/user/user_register_dto.dart';

class AuthService {
  final String baseUrl = "https://app-250519224610.azurewebsites.net/api/auth";




  Future<UserInfoDto?> login(UserLoginDto dto) async {
    try {
      print("▶ Enviando login a $baseUrl/login");
      print("📤 Payload: ${dto.toJson()}");

      final res = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dto.toJson()),
      );

      print("📥 STATUS: ${res.statusCode}");
      print("📥 BODY: ${res.body}");

      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        final user = UserInfoDto.fromJson(json);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(user.toJson()));

        return user;
      }

      return null;
    } catch (e) {
      print("❌ ERROR LOGIN: $e");
      return null;
    }
  }

  Future<bool> register(UserRegisterDto dto) async {
    try {
      print("▶ Enviando registro a $baseUrl/register");
      print("📤 Payload: ${dto.toJson()}");

      final res = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dto.toJson()),
      );

      print("📥 STATUS: ${res.statusCode}");
      print("📥 BODY: ${res.body}");

      if (res.statusCode == 200) return true;

      // Mostramos el mensaje de error devuelto por el backend (si lo hay)
      if (res.body.isNotEmpty) {
        final error = jsonDecode(res.body);
        print("❌ MENSAJE DEL SERVIDOR: $error");
      }

      return false;
    } catch (e) {
      print("❌ ERROR REGISTER: $e");
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  Future<UserInfoDto?> cargarUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('user');
    if (json == null) return null;
    return UserInfoDto.fromJson(jsonDecode(json));
  }
}
