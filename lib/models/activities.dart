class Activity {
  final int id;
  final String createdBy;
  final String date;
  final String category;
  final String location;
  final String address;
  final String description;
  final bool active;

  Activity({
    required this.id,
    required this.createdBy,
    required this.date,
    required this.category,
    required this.location,
    required this.address,
    required this.description,
    required this.active,
  });

  factory Activity.fromMap(Map<String, dynamic> json) => Activity(
    id: json['id'],
    createdBy: json['createdBy'],
    date: json['date'],
    category: json['category'],
    location: json['location'],
    address: json['address'],
    description: json['description'],
    active: json['active'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdBy': createdBy,
      'date': date,
      'category': category,
      'location': location,
      'address': address,
      'description': description,
      'active': active,
    };
  }
}
