class RiderProfile {
  final String id;
  final String displayName;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RiderProfile({
    required this.id,
    required this.displayName,
    this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
  });
}