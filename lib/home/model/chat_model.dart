class ChatModel {
  final String userFirstName;
  final String userLastName;
  final String chatUserId;
  final String userEmail;
  final String city;
  final String mobileNumber;

  ChatModel({
    required this.userFirstName,
    required this.chatUserId,
    required this.mobileNumber,
    required this.userLastName,
    required this.userEmail,
    required this.city,
  });

  // Factory constructor to create an instance from a map
  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      userFirstName: map['first_name'] ?? '',
      userLastName: map["last_name"] ?? "",
      chatUserId: map['chatUserId'] ?? '',
      mobileNumber: map["mobile_number"],
      userEmail: map['email'] ?? '',
      city: map['city'] ?? '',
    );
  }

  // Method to convert the instance to a map
  Map<String, dynamic> toMap() {
    return {
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'chatUserId': chatUserId,
      'email': userEmail,
      'city': city,
      'mobile_number': mobileNumber,
    };
  }
}
