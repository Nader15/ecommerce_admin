import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_admin/utils/colors_file.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:const EdgeInsets.only(left: 21, top: 29, right: 21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upload Image",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text("Upload Category Image image",
                    style:
                    TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(height: 30),
                CategoryImageDottedBorder(),
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
                      width:
                      MediaQuery.of(context).size.width ,
                      child: TextFormField(
                        style: TextStyle(color: whiteColor),
                        cursorColor: primaryAppColor,
                        decoration: InputDecoration(
                            fillColor:
                            Colors.grey,
                            hintText: 'Category Name',
                            hintStyle: TextStyle(
                                color: Color(0xffb8c3cb))),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Add Category Price",
                      style:
                      TextStyle(color: Colors.black,fontSize: 20,),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width:
                      MediaQuery.of(context).size.width ,
                      child: TextFormField(
                        style: TextStyle(color: whiteColor),
                        cursorColor: primaryAppColor,
                        decoration: InputDecoration(
                            fillColor:
                            Colors.grey,
                            hintText: 'Category Price',
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
                        'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            )
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

}
