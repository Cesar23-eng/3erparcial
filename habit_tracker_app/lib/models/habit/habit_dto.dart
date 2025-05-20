class HabitDto {
  final int id;
  final String name;
  final DateTime createdAt;

  HabitDto({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory HabitDto.fromJson(Map<String, dynamic> json) {
    return HabitDto(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
