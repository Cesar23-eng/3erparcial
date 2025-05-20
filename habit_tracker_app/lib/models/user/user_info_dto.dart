class UserInfoDto {
  final int id;
  final String email;
  final String role;
  final String token;

  UserInfoDto({
    required this.id,
    required this.email,
    required this.role,
    required this.token,
  });

  factory UserInfoDto.fromJson(Map<String, dynamic> json) {
    return UserInfoDto(
      id: json['id'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'token': token,
    };
  }
}
