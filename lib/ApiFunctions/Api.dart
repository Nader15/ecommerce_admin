import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_admin/error401_page.dart';
import 'package:ecommerce_admin/model/cart_model.dart';
import 'package:ecommerce_admin/model/categories_model.dart';
import 'package:ecommerce_admin/model/category_products_model.dart';
import 'package:ecommerce_admin/utils/custom_widgets/cusstom_snackBar.dart';
import 'package:ecommerce_admin/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:xs_progress_hud/xs_progress_hud.dart';

class Api {
  String baseUrl = 'https://cafeshs.herokuapp.com/api/';
  final String createCategories = "categories";
  final String createProducts = "products";
  final String createCategoryLink = "categories/create";

  BuildContext context;
  Api(@required this.context);


  Future createCategory(GlobalKey<ScaffoldState> _scaffoldKey) async {
    XsProgressHud.show(context);
    final String apiUrl = baseUrl + createCategoryLink;
    var data = {
      "name": "Nader",
      "description": "Test Category"
    };
    var userToJson = json.encode(data);
    final response = await http.post(
      apiUrl,
      headers: {"Content-Type": "application/json"},
      body: userToJson,
    );
    Map<String, dynamic> dataContent = json.decode(response.body);
    XsProgressHud.hide();
    if (response.statusCode == 200) {
      CustomSnackBar(_scaffoldKey,
          json.decode(response.body).toString());
      print(json.decode(response.body));
      return CategoriesModel.fromJson(dataContent);
    } else {
      CustomSnackBar(_scaffoldKey,
          json.decode(response.body).toString());
      return false;
    }
  }

  Future categoriesApi(GlobalKey<ScaffoldState>_scaffoldKey) async {
    XsProgressHud.show(context);

    final String completeUrl =  baseUrl + createCategories;

    final response =  await http.post(
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
    }  else if(response.statusCode == 401){
      // clearAllData();

      navigateAndClearStack(context, Error401Page());
    }else {
      CustomSnackBar(
          _scaffoldKey, json.decode(response.body).toString());
      return false;
    }

  }

  Future categoryProductsApi(GlobalKey<ScaffoldState>_scaffoldKey) async {
    XsProgressHud.show(context);

    final String completeUrl =  baseUrl + createProducts;

    final response =  await http.post(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    Map<String, dynamic> dataContent = json.decode(response.body);
    XsProgressHud.hide();
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(dataContent);
    }  else if(response.statusCode == 401){
      // clearAllData();

      navigateAndClearStack(context, Error401Page());
    }else {
      CustomSnackBar(
          _scaffoldKey, json.decode(response.body).toString());
      return false;
    }

  }

}
