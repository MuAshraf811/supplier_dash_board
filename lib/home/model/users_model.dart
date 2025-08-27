// ignore_for_file: non_constant_identifier_names

class UsersModel {
  final String first_name;
  final String last_name;
  final String mobile_number;
  final String city;
  final String email;
  final bool isSupplier;
  final String docId;

  UsersModel(
      {required this.first_name,
      required this.last_name,
      required this.mobile_number,
      required this.city,
        required this.docId,
        required this.isSupplier,
      required this.email});
  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      first_name: map['first_name'] ?? map['companyName'] ?? '',
      last_name: map['last_name'] ?? '',
      docId: map["docId"] ?? "",
      mobile_number: map['mobile_number'] ?? map['mobile']?? '',
      city: map['city'] ?? '',
      isSupplier: map['isSupplier']??false,
      email: map['email'] ?? '',
    );
  }
}
