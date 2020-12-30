import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ecommerce_admin/error401_page.dart';
import 'package:ecommerce_admin/model/add_to_cart_model.dart';
import 'package:ecommerce_admin/model/cart_content_model.dart';
import 'package:ecommerce_admin/model/categories_model.dart';
import 'package:ecommerce_admin/model/category_products_model.dart';
import 'package:ecommerce_admin/utils/custom_widgets/cusstom_snackBar.dart';
import 'package:ecommerce_admin/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xs_progress_hud/xs_progress_hud.dart';

class Api {
  String baseUrl = 'https://cafeshs.herokuapp.com/api/';
  final String createCategories = "categories";
  final String createProducts = "product/category/";
  final String products = "products";
  final String createCategoryLink = "categories/create";
  final String createProductLink = "products/create";
  final String addToCartLink = "add/cart";
  final String cartLink = "cart";

  BuildContext context;
  Api(@required this.context);

  Future uploadCategoryImageToApi(File fileName, String urlData, int id) async {
    print("${"$baseUrl$urlData/set/logo/$id"}");
    print("fileName:: ${fileName.path}");
    XsProgressHud.show(context);
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "logo": await MultipartFile.fromFile("${fileName.path}",
          filename: "${fileName.path.split('/').last}"),
    });
    var response =
        await dio.post("$baseUrl$urlData/set/logo/$id", data: formData);
    XsProgressHud.hide();
    // final response = await Dio().post("$baseUrl$urlData/set/logo/$id",
    //     data: formData, options: Options(method: "POST", headers: headers));

    print("responseresponse ${formData}");
    print("responseresponse ${response}");
    return true;
  }

  Future createCategory(
    GlobalKey<ScaffoldState> _scaffoldKey,
    String name,
    String description,
  ) async {
    XsProgressHud.show(context);
    final String apiUrl = baseUrl + createCategoryLink;
    var data = {"name": name, "description": description};
    var userToJson = json.encode(data);
    final response = await http.post(
      apiUrl,
      headers: {"Content-Type": "application/json"},
      body: userToJson,
    );
    Map<String, dynamic> dataContent = json.decode(response.body);
    XsProgressHud.hide();

    print("dataContent:: ${dataContent}");
    if (response.statusCode == 200) {
      // CustomSnackBar(_scaffoldKey,
      //     json.decode(response.body).toString());
      print(json.decode(response.body));
      return true;
    } else {
      CustomSnackBar(_scaffoldKey, json.decode(response.body).toString());
      return false;
    }
  }

  Future createProduct(GlobalKey<ScaffoldState> _scaffoldKey, String name,
      String description, String amount, String price,int categoryId) async {
    XsProgressHud.show(context);
    final String apiUrl = baseUrl + createProductLink;
    var data = {
      "name": name,
      "description": description,
      "amount": amount,
      "price": price,
      "category_id": categoryId
    };
    var userToJson = json.encode(data);
    final response = await http.post(
      apiUrl,
      headers: {"Content-Type": "application/json"},
      body: userToJson,
    );
    Map<String, dynamic> dataContent = json.decode(response.body);
    XsProgressHud.hide();

    print('dataContent"" ${dataContent}');
    print('dataContent"" ${data}');
    if (response.statusCode == 200) {
      // CustomSnackBar(_scaffoldKey,
      //     json.decode(response.body).toString());
      print(json.decode(response.body));
      return ProductsModel.fromJson(dataContent);
    } else {
      CustomSnackBar(_scaffoldKey, json.decode(response.body).toString());
      return false;
    }
  }

  Future cartContent(GlobalKey<ScaffoldState> _scaffoldKey) async {
    XsProgressHud.show(context);
    final String apiUrl = baseUrl + cartLink;
    var data = {"user_id": "12321"};
    var userToJson = json.encode(data);
    final response = await http.post(
      apiUrl,
      headers: {"Content-Type": "application/json"},
      body: userToJson,
    );
    Map<String, dynamic> dataContent = json.decode(response.body);
    XsProgressHud.hide();
    if (response.statusCode == 200) {
      print("body :" + json.decode(response.body).toString());
      return CartContentModel.fromJson(dataContent);
    } else {
      print("body :" + json.decode(response.body).toString());
      CustomSnackBar(_scaffoldKey, json.decode(response.body).toString());
      return false;
    }
  }

  Future categoriesApi(GlobalKey<ScaffoldState> _scaffoldKey) async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + createCategories;

    final response = await http.post(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    Map<String, dynamic> dataContent = json.decode(response.body);
    XsProgressHud.hide();
    if (response.statusCode == 200) {
      return CategoriesModel.fromJson(dataContent);
    } else if (response.statusCode == 401) {
      // clearAllData();

      navigateAndClearStack(context, Error401Page());
    } else {
      CustomSnackBar(_scaffoldKey, json.decode(response.body).toString());
      return false;
    }
  }

  Future categoryProductsApi(
      GlobalKey<ScaffoldState> _scaffoldKey, int categoryId) async {
    XsProgressHud.show(context);
    print("baseUrl::: ${baseUrl + createProducts + "${categoryId}"}");
    final String completeUrl = baseUrl + products;
    // final String completeUrl =  baseUrl + createProducts+"${categoryId}";

    final response = await http.post(completeUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({"user_id": "12321"}));
    Map<String, dynamic> dataContent = json.decode(response.body);
    XsProgressHud.hide();
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(dataContent);
    } else if (response.statusCode == 401) {
      // clearAllData();

      navigateAndClearStack(context, Error401Page());
    } else {
      CustomSnackBar(_scaffoldKey, json.decode(response.body).toString());
      return false;
    }
  }

  Future addToCart(GlobalKey<ScaffoldState> _scaffoldKey) async {
    XsProgressHud.show(context);
    final String apiUrl = baseUrl + addToCartLink;
    var data = {"user_id": "12321", "product_id": 1, "amount": 2};
    var userToJson = json.encode(data);
    final response = await http.post(
      apiUrl,
      headers: {"Content-Type": "application/json"},
      body: userToJson,
    );
    Map<String, dynamic> dataContent = json.decode(response.body);
    XsProgressHud.hide();
    if (response.statusCode == 200) {
      CustomSnackBar(_scaffoldKey, json.decode(response.body).toString());
      print(json.decode(response.body));
      return AddToCartModel.fromJson(dataContent);
    } else {
      CustomSnackBar(_scaffoldKey, json.decode(response.body).toString());
      return false;
    }
  }
}
