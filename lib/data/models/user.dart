class User {
  final String id;
  final String name;

  const User({
    required this.id,
    required this.name,
  });

  String get avatar {
    return name[0];
  }
}