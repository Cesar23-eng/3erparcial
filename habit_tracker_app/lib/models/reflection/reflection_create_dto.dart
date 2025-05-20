class ReflectionCreateDto {
  final String content;
  final int habitId;

  ReflectionCreateDto({
    required this.content,
    required this.habitId,
  });

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'habitId': habitId,
    };
  }
}
