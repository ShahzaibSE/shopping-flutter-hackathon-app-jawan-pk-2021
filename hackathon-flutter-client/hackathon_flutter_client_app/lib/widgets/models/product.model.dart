class ProductModel {
  String? imageUrl;
  String? name;
  String? description;
  String? price;
  String? discount;
  String? category;

  static List products = [];

  ProductModel({
    this.imageUrl,
    this.name,
    this.price,
    this.discount,
    this.description,
    this.category,
  });
}

class PreviousOrderModel {
  String? imageUrl;
  String? name;
  String? description;
  String? price;
  String? discount;
  String? previousOrder;
  String? address;
  String? about;
  String? policy;
  String? orderNumber;

  PreviousOrderModel({
    this.imageUrl,
    this.name,
    this.price,
    this.discount,
    this.description,
    this.previousOrder,
    this.address,
    this.about,
    this.policy,
    this.orderNumber,
  });

  static List previousOrderList = [];
}
