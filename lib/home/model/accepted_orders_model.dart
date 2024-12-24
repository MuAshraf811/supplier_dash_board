class AcceptedOrdersModel {
  final String name;
  final String email;
  final String address;
  final String mobile;
  final String date;
  final String orderType;
  final String details;
  // ignore: non_constant_identifier_names
  final String extra_details;
  final String orderId;
  final String category;
  AcceptedOrdersModel({
    required this.name,
    required this.email,
    required this.address,
    required this.mobile,
    required this.date,
    required this.orderType,
    required this.details,
    required this.extra_details,
    required this.category,
    required this.orderId,
  });

  // Factory constructor to create an instance from a map
  factory AcceptedOrdersModel.fromMap(Map<String, dynamic> map) {
    return AcceptedOrdersModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      mobile: map['mobile'] ?? '',
      category: map["category"],
      orderId: map["orderId"],
      date: map['date'] ?? '',
      orderType: map['orderType'] ?? '',
      details: map['details'] ?? '',
      extra_details: map['extra_details'] ?? '',
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'mobile': mobile,
      'date': date,
      'orderType': orderType,
      'details': details,
    };
  }
}
