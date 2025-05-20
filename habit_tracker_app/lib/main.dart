import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/user/user_info_dto.dart';
import 'screens/login_screen.dart';
import 'screens/user_home_screen.dart';
import 'screens/coach_home_screen.dart';
import 'screens/unknown_role_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RootPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  Widget? screen;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('user');

    if (json == null) {
      setState(() => screen = const LoginScreen());
    } else {
      final user = UserInfoDto.fromJson(jsonDecode(json));
      switch (user.role) {
        case 'User':
          setState(() => screen = const UserHomeScreen());
          break;
        case 'Coach':
          setState(() => screen = const CoachHomeScreen());
          break;
        default:
          setState(() => screen = const UnknownRoleScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return screen ?? const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
