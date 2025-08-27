class SupplierModel {
  final String companyName;
  final String email;
  final String mobile;
  final String city;
  final String bankName;
  final String taxNumber;
  final String tradeLicense;
  final String iPanNumber;
  final String docId;
  final bool approved;
  SupplierModel({
    required this.companyName,
    required this.email,
    required this.docId,
    required this.mobile,
    required this.city,
    required this.bankName,
    required this.taxNumber,
    required this.tradeLicense,
    required this.iPanNumber,
    required this.approved
  });

  factory SupplierModel.fromMap(Map<String, dynamic> map) {
    return SupplierModel(
      companyName: map['companyName'] ?? '',
      email: map['email'] ?? '',
      docId: map['docId'],
      mobile: map['mobile'] ?? '',
      city: map['city'] ?? '',
      bankName: map['bankName'] ?? '',
      taxNumber: map['taxNumber'] ?? '',
      tradeLicense: map['imagePath'] ?? '',
      iPanNumber: map['ipanNumber'] ?? '',
      approved: map['approved'] != null ?(map['approved'] == "TRUE"):false,
    );
  }

  // Method to convert SupplierModel to Map
  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'email': email,
      'mobile': mobile,
      'city': city,
      'bankName': bankName,
      'taxNumber': taxNumber,
      'tradeLicense': tradeLicense,
      'iPanNumber': iPanNumber,
    };
  }
}
