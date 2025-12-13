class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.hoodPoints = 0,
    this.verified = false,
  });

  final String id;
  final String name;
  final String email;
  final int hoodPoints;
  final bool verified;

  UserModel copyWith({
    String? name,
    String? email,
    int? hoodPoints,
    bool? verified,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      hoodPoints: hoodPoints ?? this.hoodPoints,
      verified: verified ?? this.verified,
    );
  }
}
