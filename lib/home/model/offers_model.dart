class OffersModel {
  final String supplierName;
  final String supplierDataId;
  final String orderNumber;
  final String offerId;
  final String offerDate;
  final String offerDescription;
  final String amount;
  final String quantity;
  final String rate;
  final String mobile;
  final String city;
  final String email;
  final String deliverDate;
  final String total;
  final String vat;

  OffersModel({
    required this.supplierName,
    required this.supplierDataId,
    required this.orderNumber,
    required this.offerId,
    required this.offerDate,
    required this.offerDescription,
    required this.amount,
    required this.mobile,
    required this.city,
    required this.email,
    required this.quantity,
    required this.rate,
    required this.deliverDate,
    required this.total,
    required this.vat
  });
  factory OffersModel.fromMap(Map<String, dynamic> map) {
    return OffersModel(
      amount: map['amount'] ?? "",
      city: map["city"] ?? "",
      deliverDate: map["deliverDate"]??"",
      email: map["email"] ?? "",
      mobile: map["mobile"] ?? "",
      orderNumber: map['orderNumber'] ?? "",
      quantity: map['quantity'] ?? "",
      offerDate: map['quotationDate'] ?? "",
      offerDescription: map['quotationDescription'] ?? "",
      rate: map['rate'] ?? "",
      supplierDataId: map['supplierId'] ?? "",
      supplierName: map['supplierName'] ?? "",
      total:  map['total'] ?? "",
      vat: map['vat'] ?? "" ,

      offerId: map['offerId'] ?? "",
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toMap() {
    return {
      'supplierName': supplierName,
      'supplierId': supplierDataId,
      'orderNumber': orderNumber,
      'offerId': offerId,
      'offerDate': offerDate,
      'offerDescription': offerDescription,
      'amount': amount,
      'quantity': quantity,
      'rate': rate,
    };
  }


  String toStr(){
    return "Description: $offerDescription,\nAmount: $amount, \nRate: $rate, \nQuantity: $quantity \nVat%: $vat \nTotal: $total\nDeliver Date: $deliverDate";
  }

}
