import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_admin/ApiFunctions/Api.dart';
import 'package:ecommerce_admin/model/categories_model.dart';
import 'package:ecommerce_admin/model/category_products_model.dart'as product;
import 'package:ecommerce_admin/model/category_products_model.dart';
import 'package:ecommerce_admin/ui/categories/categories.dart';
import 'package:ecommerce_admin/ui/subcategories/category_products.dart';
import 'package:ecommerce_admin/utils/colors_file.dart';
import 'package:ecommerce_admin/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  int categoryId;


  AddProduct(this.categoryId);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {


   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   GlobalKey<FormState> formKey = GlobalKey<FormState>();





  bool _autoValidate = false;

  var name = TextEditingController();
  var description = TextEditingController();
  // var amount = TextEditingController();
  var price = TextEditingController();
  var name_ar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,

        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_backspace,
              color: Colors.black,
            ),
          ),

          title: Text(
            "Add Product",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                  padding:const EdgeInsets.only(left: 21, top: 29, right: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add Product English Name",
                            style:
                            TextStyle(color: Colors.black,fontSize: 20,),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              style: TextStyle(color: blackColor),
                              cursorColor: primaryAppColor,
                              controller: name,
                              keyboardType: TextInputType.name,
                              validator: validateName,
                              decoration: InputDecoration(
                                fillColor:
                                Colors.grey,
                                hintText: 'English Name',
                                hintStyle: TextStyle(
                                  color: Color(0xffb8c3cb),),),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            "Add Product Arabic Name",
                            style:
                            TextStyle(color: Colors.black,fontSize: 20,),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              style: TextStyle(color: blackColor),
                              cursorColor: primaryAppColor,
                              controller: name_ar,
                              keyboardType: TextInputType.name,
                              validator: validateName,
                              decoration: InputDecoration(
                                fillColor:
                                Colors.grey,
                                hintText: 'Arabic Name',
                                hintStyle: TextStyle(
                                  color: Color(0xffb8c3cb),),),
                            ),
                          ),
                          // SizedBox(height: 20),
                          // Text(
                          //   "Add Product Description",
                          //   style:
                          //   TextStyle(color: Colors.black,fontSize: 20,),
                          // ),
                          // SizedBox(height: 10),
                          // SizedBox(
                          //   width:
                          //   MediaQuery.of(context).size.width ,
                          //   child: TextFormField(
                          //     style: TextStyle(color: blackColor),
                          //     cursorColor: primaryAppColor,
                          //     controller: description,
                          //     keyboardType: TextInputType.name,
                          //     validator: validateDescription,
                          //     decoration: InputDecoration(
                          //         fillColor:
                          //         Colors.grey,
                          //         hintText: 'Product Description',
                          //         hintStyle: TextStyle(
                          //             color: Color(0xffb8c3cb))),
                          //   ),),
                          // SizedBox(height: 20),
                          // Text(
                          //   "Add Amount",
                          //   style:
                          //   TextStyle(color: Colors.black,fontSize: 20,),
                          // ),
                          // SizedBox(height: 10),
                          // SizedBox(
                          //   width:
                          //   MediaQuery.of(context).size.width ,
                          //   child: TextFormField(
                          //     style: TextStyle(color: blackColor),
                          //     cursorColor: primaryAppColor,
                          //     controller: amount,
                          //     keyboardType: TextInputType.number,
                          //     validator: validateAmount,
                          //     decoration: InputDecoration(
                          //         fillColor:
                          //         Colors.grey,
                          //         hintText: 'product amount',
                          //         hintStyle: TextStyle(
                          //             color: Color(0xffb8c3cb))),
                          //   ),),
                          SizedBox(height: 20),
                          Text(
                            "Add Price",
                            style:
                            TextStyle(color: Colors.black,fontSize: 20,),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width:
                            MediaQuery.of(context).size.width ,
                            child: TextFormField(
                              style: TextStyle(color: blackColor),
                              cursorColor: primaryAppColor,
                              controller: price,
                              keyboardType: TextInputType.number,
                              validator: validateprice,
                              decoration: InputDecoration(
                                  fillColor:
                                  Colors.grey,
                                  hintText: 'product price',
                                  hintStyle: TextStyle(
                                      color: Color(0xffb8c3cb))),
                            ),),
                        ],
                      ),
                      SizedBox(height: 60,),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 21.0),
                        child: ButtonTheme(
                          minWidth: 280.0,
                          height: 45.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.grey,
                            child: Text(
                              'Add Product',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            onPressed: () {
                              _validateInputs();
                              if (formKey.currentState.validate()) {
                                Api(context)
                                    .createProduct(_scaffoldKey,name.text,description.text,price.text,widget.categoryId,name_ar.text)
                                    .then((value) {
                                  navigateAndClearStack(context, Categories());
                                });


                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),
        )
    );
  }



  void _validateInputs() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  String validateName(String value) {
    if (value.length == 0)
      return 'enter product name';
    else
      return null;
  }
  String validateDescription(String value) {
    if (value.length == 0)
      return 'enter product Description';
    else
      return null;
  }

  String validateAmount(String value) {
    if (value.length == 0)
      return 'enter product amount';
    else
      return null;
  }

  String validateprice(String value) {
    if (value.length == 0)
      return 'enter product price';
    else
      return null;
  }
}
