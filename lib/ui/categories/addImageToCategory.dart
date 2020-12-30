import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_admin/ApiFunctions/Api.dart';
import 'package:ecommerce_admin/ui/categories/categories.dart';
import 'package:ecommerce_admin/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  bool fromCategory;
int id;
  AddImage(this.fromCategory,this.id);

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File _image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),

        centerTitle: true,title: Text("Upload Image",style: TextStyle(color: Colors.black),),),
      body: Container(child: Column(children: [

        SizedBox(height: 16),
        Text("Upload Category Image image",
            style:
            TextStyle(fontSize: 16, color: Colors.grey)),
        SizedBox(height: 30),
        CategoryImageDottedBorder(),

        SizedBox(height: 30),
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
                'Add Image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {

           Api(context).uploadCategoryImageToApi(_image, widget.fromCategory?"categories":"products", widget.id).then((value) {
             navigateAndClearStack(context,Categories());

           });
              },
            ),
          ),
        ),
      ],),),
    );
  }
}
