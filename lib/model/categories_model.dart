
class CategoriesModel {
  List<Success> success;
  int code;

  CategoriesModel({this.success, this.code});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      success = new List<Success>();
      json['success'].forEach((v) {
        success.add(new Success.fromJson(v));
      });
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
  dynamic createdAt;
  dynamic updatedAt;
  String name;
  dynamic logo;
  String description;

  Success(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.logo,
        this.description});

  Success.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    logo = json['logo'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['description'] = this.description;
    return data;
  }
}
