import 'package:flutter/material.dart';
import 'package:habit_trackerapp/screens/login_screen.dart';
import 'package:habit_trackerapp/services/api_service.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  void _logout(BuildContext context) async {
    await ApiService().logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Hábitos"),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(
        child: Text("Aquí irá la lista de hábitos del usuario"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí iría el formulario para agregar hábito
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
