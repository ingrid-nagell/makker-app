class User {
  final int userId;
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  User({
    required this.userId,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['UserID'],
      email: map['Email'],
      password: map['Password'],
      firstName: map['FirstName'],
      lastName: map['LastName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'UserID': userId,
      'Email': email,
      'Password': password,
      'FirstName': firstName,
      'LastName': lastName,
    };
  }
}
