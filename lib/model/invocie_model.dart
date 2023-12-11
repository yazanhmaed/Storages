class InVocieModel {
  int? id;
  String? date;
  int? itemNumber;
  String? itemName;
  int? itemPrice;
  int? itemCost;
  int? itemFill;
  int? itemCount;
  int? customerId;

  InVocieModel({
    this.id,
    this.date,
    this.itemNumber,
    this.itemName,
    this.itemPrice,
    this.itemCost,
    this.itemFill,
    this.itemCount,
    this.customerId,
  });
  InVocieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    itemNumber = json['itemNumber'];
    itemName = json['itemName'];
    itemPrice = json['itemPrice'];
    itemCost = json['itemCost'];
    itemFill = json['itemFill'];
    itemCount = json['itemCount'];
    customerId = json['customerId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'itemNumber': itemNumber,
      'itemName': itemName,
      'itemPrice': itemPrice,
      'itemCost': itemCost,
      'itemFill': itemFill,
      'itemCount': itemCount,
      'customerId': customerId,
    };
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['itemNumber'] = itemNumber;
  //   data['itemName'] = itemName;
  //   data['itemPrice'] = itemPrice;
  //   data['itemCost'] = itemCost;
  //   data['itemFill'] = itemFill;
  //   data['itemCount'] = itemCount;
  //   return data;
  // }
}
