class OffersModel {
  final String supplierName;
  final String supplierId;
  final String orderNumber;
  final String offerId;
  final String offerDate;
  final String offerDescription;
  final String amount;
  final String quantity;
  final String rate;
  final String mobile;
  final String city;
  final String emial;
  OffersModel(
      {required this.supplierName,
      required this.supplierId,
      required this.orderNumber,
      required this.offerId,
      required this.offerDate,
      required this.offerDescription,
      required this.amount,
      required this.mobile,
      required this.city,
      required this.emial,
      required this.quantity,
      required this.rate});
  factory OffersModel.fromMap(Map<String, dynamic> map) {
    return OffersModel(
      supplierName: map['supplierName'] ?? "",
      supplierId: map['supplierId'] ?? "",
      orderNumber: map['orderNumber'] ?? "",
      city: map["city"] ?? "",
      mobile: map["mobile"] ?? "",
      emial: map["email"] ?? "",
      offerId: map['offerId'] ?? "",
      offerDate: map['quotationDate'] ?? "",
      offerDescription: map['quotationDescription'] ?? "",
      amount: map['amount'] ?? "",
      quantity: map['quantity'] ?? "",
      rate: map['rate'] ?? "",
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toMap() {
    return {
      'supplierName': supplierName,
      'supplierId': supplierId,
      'orderNumber': orderNumber,
      'offerId': offerId,
      'offerDate': offerDate,
      'offerDescription': offerDescription,
      'amount': amount,
      'quantity': quantity,
      'rate': rate,
    };
  }
}
