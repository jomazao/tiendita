class AppUser {
  final String id;
  final String name;

  AppUser({required this.name, required this.id});

  factory AppUser.fromJson({
    required Map json,
    required String id,
  }) =>
      AppUser(
        name: json['name'],
        id: id,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
