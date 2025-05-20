class ReflectionDto {
  final int id;
  final String content;
  final DateTime date;
  final int habitId;
  final String habitName;

  ReflectionDto({
    required this.id,
    required this.content,
    required this.date,
    required this.habitId,
    required this.habitName,
  });

  factory ReflectionDto.fromJson(Map<String, dynamic> json) {
    return ReflectionDto(
      id: json['id'],
      content: json['content'],
      date: DateTime.parse(json['date']),
      habitId: json['habitId'],
      habitName: json['habitName'],
    );
  }
}
