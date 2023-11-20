class ItemModel {
  int? itemNumber;
  String? itemName;
  int? itemPrice;
  int? itemCost;
  int? itemFill;
  int? itemCount;
  int? itemCountb;
  int? itemCostb;
  

  ItemModel({
    this.itemNumber,
    this.itemName,
    this.itemPrice,
    this.itemCost,
    this.itemFill,
    this.itemCount,
    this.itemCountb,
    this.itemCostb,
  });
  ItemModel.fromJson(Map<String, dynamic> json) {
    itemNumber = json['itemNumber'];
    itemName = json['itemName'];
    itemPrice = json['itemPrice'];
    itemCost = json['itemCost'];
    itemFill = json['itemFill'];
    itemCount = json['itemCount'];
    itemCountb = json['itemCountb'];
    itemCostb = json['itemCostb'];
  }

  Map<String, dynamic> toMap() {
    return {
      'itemNumber': itemNumber,
      'itemName': itemName,
      'itemPrice': itemPrice,
      'itemCost': itemCost,
      'itemFill': itemFill,
      'itemCount': itemCount,
      'itemCountb': itemCountb,
      'itemCostb': itemCostb,
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
