import 'package:flutter/material.dart';
import 'package:habit_trackerapp/models/user/user_login_dto.dart';
import 'package:habit_trackerapp/services/auth_service.dart';
import 'package:habit_trackerapp/screens/user_home_screen.dart';
import 'package:habit_trackerapp/screens/coach_home_screen.dart';
import 'package:habit_trackerapp/screens/unknown_role_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _loading = false;
  String? _error;

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final dto = UserLoginDto(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    final user = await _authService.login(dto);

    setState(() {
      _loading = false;
    });

    if (user == null) {
      setState(() => _error = "Correo o contraseña incorrectos.");
      return;
    }

    switch (user.role) {
      case "User":
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const UserHomeScreen()));
        break;
      case "Coach":
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const CoachHomeScreen()));
        break;
      default:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const UnknownRoleScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar sesión")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _loading ? null : _login,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text("Ingresar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()));
              },
              child: const Text("¿No tenés cuenta? Registrate"),
            )
          ],
        ),
      ),
    );
  }
}
