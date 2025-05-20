class HabitCreateDto {
  final String name;

  HabitCreateDto({required this.name});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
