class Activity {
  final int activityId;
  final String activityTitle;
  final String activityDate;
  final String activityCategory;
  final String activityType;
  final String activityLocation;
  final String activityRendezvous;
  final String activityDescription;
  final bool isActive;
  final int createdBy;

  Activity({
    required this.activityId,
    required this.activityTitle,
    required this.activityDate,
    required this.activityCategory,
    required this.activityType,
    required this.activityLocation,
    required this.activityRendezvous,
    required this.activityDescription,
    required this.isActive,
    required this.createdBy,
  });

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      activityId: map['ActivityID'],
      activityTitle: map['ActivityTitle'],
      activityDate: map['ActivityDate'],
      activityCategory: map['ActivityCategory'],
      activityType: map['ActivityType'],
      activityLocation: map['ActivityLocation'],
      activityRendezvous: map['ActivityRendezvous'],
      activityDescription: map['ActivityDescription'],
      isActive: map['ActivityIsActive'] == 1,
      createdBy: map['CreatedBy'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ActivityID': activityId,
      'ActivityTitle': activityTitle,
      'ActivityDate': activityDate,
      'ActivityCategory': activityCategory,
      'ActivityType': activityType,
      'ActivityLocation': activityLocation,
      'ActivityRendezvous': activityRendezvous,
      'ActivityDescription': activityDescription,
      'ActivityIsActive': isActive ? 1 : 0,
      'CreatedBy': createdBy,
    };
  }
}
