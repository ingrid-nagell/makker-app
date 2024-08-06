class Activity {
  final int id;
  final String createdBy;
  final String category;
  final String name;
  final String location;
  final String date;
  final String description;
  final bool active;

  Activity({
    required this.id,
    required this.createdBy,
    required this.category,
    required this.name,
    required this.location,
    required this.date,
    required this.description,
    required this.active,
  });
}
