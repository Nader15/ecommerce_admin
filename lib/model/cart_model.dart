class CartModel {
  List<Success> success;
  int code;

  CartModel({this.success, this.code});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      success = new List<Success>();
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Success {
  int id;
  String createdAt;
  String updatedAt;
  int amount;
  int userId;
  int productId;
  Product product;

  Success(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.amount,
        this.userId,
        this.productId,
        this.product});

  Success.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    amount = json['amount'];
    userId = json['user_id'];
    productId = json['product_id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['amount'] = this.amount;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Product {
  int id;
  Null createdAt;
  Null updatedAt;
  String name;
  String description;
  int sold;
  int amount;
  String price;
  Null ofer;
  Null photo;
  String totalRate;
  int totalNumberRates;
  int categoryId;
  int popular;

  Product(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.description,
        this.sold,
        this.amount,
        this.price,
        this.ofer,
        this.photo,
        this.totalRate,
        this.totalNumberRates,
        this.categoryId,
        this.popular});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    description = json['description'];
    sold = json['sold'];
    amount = json['amount'];
    price = json['price'];
    ofer = json['ofer'];
    photo = json['photo'];
    totalRate = json['total_rate'];
    totalNumberRates = json['total_number_rates'];
    categoryId = json['category_id'];
    popular = json['popular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['description'] = this.description;
    data['sold'] = this.sold;
    data['amount'] = this.amount;
    data['price'] = this.price;
    data['ofer'] = this.ofer;
    data['photo'] = this.photo;
    data['total_rate'] = this.totalRate;
    data['total_number_rates'] = this.totalNumberRates;
    data['category_id'] = this.categoryId;
    data['popular'] = this.popular;
    return data;
  }
}
