class HabitDto {
  final int id;
  final String name;
  final String description;
  final String frequency;

  HabitDto({
    required this.id,
    required this.name,
    required this.description,
    required this.frequency,
  });

  factory HabitDto.fromJson(Map<String, dynamic> json) => HabitDto(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        frequency: json['frequency'],
      );
}
