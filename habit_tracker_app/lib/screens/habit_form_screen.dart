import 'package:flutter/material.dart';
import '../models/habit/habit_create_dto.dart';
import '../services/api_service.dart';

class HabitFormScreen extends StatefulWidget {
  const HabitFormScreen({super.key});

  @override
  State<HabitFormScreen> createState() => _HabitFormScreenState();
}

class _HabitFormScreenState extends State<HabitFormScreen> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final freqController = TextEditingController();

  Future<void> _submit() async {
    final dto = HabitCreateDto(
      name: nameController.text,
      description: descController.text,
      frequency: freqController.text,
    );

    final success = await ApiService().createHabit(dto);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Hábito creado')),
      );
      Navigator.pop(context); // o limpiar campos
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Error al crear el hábito')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nuevo Hábito")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Nombre")),
            TextField(controller: descController, decoration: const InputDecoration(labelText: "Descripción")),
            TextField(controller: freqController, decoration: const InputDecoration(labelText: "Frecuencia (ej. Diario)")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: const Text("Guardar")),
          ],
        ),
      ),
    );
  }
}
