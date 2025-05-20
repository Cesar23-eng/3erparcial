import 'package:flutter/material.dart';
import 'package:habit_trackerapp/models/reflection/reflection_create_dto.dart';
import 'package:habit_trackerapp/services/api_service.dart';

class ReflectionFormScreen extends StatefulWidget {
  final int habitId;

  const ReflectionFormScreen({super.key, required this.habitId});

  @override
  State<ReflectionFormScreen> createState() => _ReflectionFormScreenState();
}

class _ReflectionFormScreenState extends State<ReflectionFormScreen> {
  final _contentController = TextEditingController();
  bool _loading = false;
  String? _mensaje;

  Future<void> _guardar() async {
    setState(() {
      _loading = true;
      _mensaje = null;
    });

    final dto = ReflectionCreateDto(
      content: _contentController.text.trim(),
      habitId: widget.habitId,
    );

    final res = await ApiService().post('reflections', dto.toJson());

    setState(() {
      _loading = false;
      _mensaje = res?.statusCode == 200 ? "Guardado correctamente" : "Error";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nueva Reflexión")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: "¿Cómo te sentiste hoy?"),
              maxLines: 4,
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
