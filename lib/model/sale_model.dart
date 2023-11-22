class SaleModel {
  int? itemNumber;
  String? itemName;
  int? itemPrice;
  int? itemCost;
  int? itemFill;
  int? itemCount;
  int? itemCountb;
  int? itemCostb;

  SaleModel({
    this.itemNumber,
    this.itemName,
    this.itemPrice,
    this.itemCost,
    this.itemFill,
    this.itemCount,
    this.itemCountb,
    this.itemCostb,
  });
  SaleModel.fromJson(Map<String, dynamic> json) {
    itemNumber = json['itemNumber'];
    itemName = json['itemName'];
    itemPrice = json['itemPrice'];
    itemCost = json['itemCost'];
    itemFill = json['itemFill'];
    itemCount = json['itemCount'];
    itemCountb = 1;
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
}
