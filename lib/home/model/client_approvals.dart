class ClientApprovalsModel {
  final String supplierName;
  final String clientEmail;
  final String supplierDataId;
  final String orderNumber;
  final String offerId;
  final String offerDate;


  ClientApprovalsModel({
    required this.supplierName,
    required this.clientEmail,
    required this.supplierDataId,
    required this.orderNumber,
    required this.offerId,
    required this.offerDate
  });
  factory ClientApprovalsModel.fromMap(Map<String, dynamic> map) {
    return ClientApprovalsModel(
      orderNumber: map['orderId'] ?? "",
      offerDate: map['offerDate'] ?? "",
      supplierDataId: map['supplierId'] ?? "",
      supplierName: map['supplierName'] ?? "",
      clientEmail: map['clientEmail']?? "",
      offerId: map['offerId'] ?? "",
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toMap() {
    return {
      'supplierName': supplierName,
      'supplierId': supplierDataId,
      'orderId': orderNumber,
      'offerId': offerId,
      'offerDate': offerDate,
    };
  }

}
