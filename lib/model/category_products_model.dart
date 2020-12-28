class ProductsModel {
  Success success;
  int code;

  ProductsModel({this.success, this.code});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    success =
    json['success'] != null ? new Success.fromJson(json['success']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Success {
  int currentPage;
  List<Data> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Links> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Success(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Success.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int id;
  dynamic createdAt;
  dynamic updatedAt;
  String name;
  String description;
  int sold;
  int amount;
  String price;
  String ofer;
  dynamic photo;
  String totalRate;
  int totalNumberRates;
  int categoryId;
  int popular;
  int isCart;
  int cartAmount;

  Data(
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
        this.popular,
        this.isCart,
        this.cartAmount});

  Data.fromJson(Map<String, dynamic> json) {
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
    isCart = json['isCart'];
    cartAmount = json['cart_amount'];
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
    data['isCart'] = this.isCart;
    data['cart_amount'] = this.cartAmount;
    return data;
  }
}

class Links {
  dynamic url;
  dynamic label;
  bool active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
