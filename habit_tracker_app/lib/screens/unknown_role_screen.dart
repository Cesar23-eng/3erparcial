import 'package:flutter/material.dart';
import 'package:habit_trackerapp/services/auth_service.dart';
import 'package:habit_trackerapp/screens/login_screen.dart';

class UnknownRoleScreen extends StatelessWidget {
  const UnknownRoleScreen({super.key});

  void _logout(BuildContext context) async {
    await AuthService().logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rol desconocido"),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(
        child: Text("Tu rol no tiene interfaz en esta app."),
      ),
    );
  }
}
