// ignore_for_file: non_constant_identifier_names

class UsersModel {
  final String first_name;
  final String last_name;
  final String mobile_number;
  final String city;
  final String email;
  final String docId;

  UsersModel(
      {required this.first_name,
      required this.last_name,
      required this.mobile_number,
      required this.city,
      required this.docId,
      required this.email});
  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      first_name: map['first_name'] ?? 'Muhammed',
      last_name: map['last_name'] ?? 'Ashraf',
      docId: map["docId"] ?? "",
      mobile_number: map['mobile_number'] ?? '01002011850',
      city: map['city'] ?? 'Cairo',
      email: map['email'] ?? 'mo.ashraf811@gmail.com',
    );
  }
}
