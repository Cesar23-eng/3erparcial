class HabitCreateDto {
  final String name;
  final String description;
  final String frequency;

  HabitCreateDto({
    required this.name,
    required this.description,
    required this.frequency,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'frequency': frequency,
      };
}
