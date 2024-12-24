// ignore_for_file: non_constant_identifier_names

class OrdersModel {
  final String details;
  final String extea_details;
  final String date;
  final String category;
  final String orderType;
  final String userId;
  final String orderId;
  final String email;
  final String name;
  final String address;
  final String mobile;
  OrdersModel({
    required this.details,
    required this.extea_details,
    required this.date,
    required this.orderId,
    required this.category,
    required this.orderType,
    required this.userId,
    required this.address,
    required this.email,
    required this.mobile,
    required this.name,
  });

  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return OrdersModel(
      details: map['details'].toString().replaceAll("\n", " || ") as String? ??
          'Something went wrong',
      orderId: map["orderId"] ?? "",
      address: map["address"] ?? "",
      mobile: map["mobile"] ?? "",
      email: map["email"] ?? '',
      name: map["name"] ?? "",
      extea_details: map['extra_details'] ?? 'there is no extra details',
      date: (map['date'] != null)
          ? (map['date'])
          : DateTime.now().toString(), // Handle Firestore Timestamp
      category: map['category'] as String? ?? 'Something went wrong',
      orderType: map['orderType'] as String? ?? 'Something went wrong',
      userId: map['userId'] as String? ?? 'Error While getting user id',
    );
  }
}
