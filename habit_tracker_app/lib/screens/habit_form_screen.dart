import 'package:flutter/material.dart';
import 'package:habit_trackerapp/models/habit/habit_create_dto.dart';
import 'package:habit_trackerapp/services/api_service.dart';

class HabitFormScreen extends StatefulWidget {
  const HabitFormScreen({super.key});

  @override
  State<HabitFormScreen> createState() => _HabitFormScreenState();
}

class _HabitFormScreenState extends State<HabitFormScreen> {
  final _nameController = TextEditingController();
  bool _loading = false;
  String? _mensaje;

  Future<void> _guardar() async {
    setState(() {
      _loading = true;
      _mensaje = null;
    });

    final dto = HabitCreateDto(name: _nameController.text.trim());
    final res = await ApiService().post('habits', dto.toJson());

    setState(() {
      _loading = false;
      _mensaje = res?.statusCode == 200 ? "Guardado correctamente" : "Error al guardar";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nuevo Hábito")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Nombre del hábito"),
            ),
            const SizedBox(height: 16),
            if (_mensaje != null)
              Text(_mensaje!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _loading ? null : _guardar,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text("Guardar"),
            )
          ],
        ),
      ),
    );
  }
}
