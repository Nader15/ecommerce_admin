import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_admin/ApiFunctions/Api.dart';
import 'package:ecommerce_admin/model/categories_model.dart';
import 'package:ecommerce_admin/ui/categories/categories.dart';
import 'package:ecommerce_admin/utils/colors_file.dart';
import 'package:ecommerce_admin/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  CategoriesModel categoriesModel;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> scafoldState = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Success> categoryList = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 0), () {
    });

//    showHud();
  }


  addToCartApi() {
    setState(() {
      Api(context).createCategory(_scaffoldKey,name.text,description.text).then((value) {
        categoriesModel = value;
        categoriesModel.success.forEach((element) {
          setState(() {
            categoryList.add(element);
          });
        });
      });
    });
  }
  bool _autoValidate = false;
  var name = TextEditingController();
  var description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding:const EdgeInsets.only(left: 21, top: 29, right: 21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Upload Image",
                  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  // ),
                  // SizedBox(height: 16),
                  // Text("Upload Category Image image",
                  //     style:
                  //     TextStyle(fontSize: 16, color: Colors.grey)),
                  // SizedBox(height: 30),
                  // CategoryImageDottedBorder(),
                  SizedBox(height: 55),
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add Category Name",
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
                              hintText: 'Category Name',
                              hintStyle: TextStyle(
                                  color: Color(0xffb8c3cb),),),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Add Category Description",
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
                          controller: description,
                          keyboardType: TextInputType.name,
                          validator: validateDescription,
                          decoration: InputDecoration(
                              fillColor:
                              Colors.grey,
                              hintText: 'Category Description',
                              hintStyle: TextStyle(
                                  color: Color(0xffb8c3cb))),
                        ),)
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
                          'Add Category',
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
                                .createCategory(scafoldState,name.text,description.text)
                                .then((value) {
                              if (value is CategoriesModel) {
                                categoriesModel = value;
                              }
                            });
                            Navigator.pop(context);
                            navigateAndKeepStack(context, Categories());
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

  DottedBorder CategoryImageDottedBorder(){
    return DottedBorder(
        radius: Radius.circular(30),
        color: Colors.grey,
        dashPattern: [5,5],
        strokeCap: StrokeCap.round
        ,
        child: _image == null ?
        Container(
          height: 199,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Recommended Size (500*500)",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  "No images added yet !",
                  style: TextStyle(color: Colors.grey),
                ),
                RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Colors.blue[50],
                  child: Text(
                    'Select Image',
                    style: TextStyle(
                      color: Color(0xff1d4ca1),
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  onPressed: (){
                    getImage();
                  },
                ),
              ],
            ),
          ),
        ) : Container(
          height: 199,
          width: MediaQuery.of(context).size.width,
          child: Image.file(_image),
        ),
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
      return 'enter Category name';
    else
      return null;
  }
  String validateDescription(String value) {
    if (value.length == 0)
      return 'enter Category Description';
    else
      return null;
  }

}
