class UserSettings {
  final String name;
  final String email;
  final String phone;
  final bool receiveNewsletter;

  const UserSettings({
    required this.name,
    required this.email,
    required this.phone,
    required this.receiveNewsletter,
  });
}