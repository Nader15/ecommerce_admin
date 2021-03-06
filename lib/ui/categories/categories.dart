import 'package:ecommerce_admin/ApiFunctions/Api.dart';
import 'package:ecommerce_admin/model/categories_model.dart' as category;
import 'package:ecommerce_admin/ui/subcategories/category_products.dart';
import 'package:ecommerce_admin/utils/colors_file.dart';
import 'package:ecommerce_admin/utils/global_vars.dart';
import 'package:ecommerce_admin/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

import 'add_category.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  category.CategoriesModel categoriesModel;
  List<category.Success> categoriesList = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 0), () {
      gettingData();
    });
//    showHud();
  }

  gettingData() {
    setState(() {
      Api(context).categoriesApi(_scaffoldKey).then((value) {
        categoriesList = List();
        categoriesModel = value;
        categoriesModel.success.forEach((element) {
          setState(() {
            categoriesList.add(element);
          });
        });
        categoriesList = categoriesList.reversed.toList();
      });
    });
  }

  Future<bool> removeCategory(BuildContext context, int categoryId) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Text(
                  "Are you sure to delete this category",
                  style: TextStyle(fontFamily: "BoutrosAsma_Regular"),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          border: Border.all(
                              width: 1,
                              color: Colors
                                  .grey //                   <--- border width here
                              ),
                        ),
                        child: Text(
                          "cancel",
                          style: TextStyle(color: Colors.white),
                        )),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  GestureDetector(
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          border: Border.all(
                              width: 1,
                              color: Colors
                                  .grey //                   <--- border width here
                              ),
                        ),
                        child: Text(
                          "yes",
                          style: TextStyle(color: Colors.white),
                        )),
                    onTap: () {
                      Api(context)
                          .removeCategory(_scaffoldKey, categoryId)
                          .then((value) {
                        Navigator.of(context).pop();
                        gettingData();
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Text(
                  "Are you sure to logOut",
                  style: TextStyle(fontFamily: "BoutrosAsma_Regular"),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          border: Border.all(
                              width: 1,
                              color: Colors
                                  .grey //                   <--- border width here
                              ),
                        ),
                        child: Text(
                          "Exit",
                          style: TextStyle(color: Colors.white),
                        )),
                    onTap: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                  ),
                  GestureDetector(
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          border: Border.all(
                              width: 1,
                              color: Colors
                                  .grey //                   <--- border width here
                              ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        )),
                    onTap: () {
                      print('Tappped');
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  String message='';
  _onScrollStart(ScrollMetrics metrics){
    message = 'Scroll Start';
    setState(() {
      print("Scroll Start");
    });
  }
  _onScrollUpdate(ScrollMetrics metrics){
    message = 'Scroll Update';
    setState(() {
      print("Scroll Update");
    });
  }
  _onScrollend(ScrollMetrics metrics){
    message = 'Scroll End';
    setState(() {
      print('Scroll End');
      print(metrics.pixels);
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        floatingActionButton: _buildFloatingButton(),
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "Categories",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              categoriesList.length == 0
                  ? Center(
                      child: Container(
                        child: Text("No data found"),
                      ),
                    )
                  : Expanded(
                      child: NotificationListener<ScrollNotification>(
                        // ignore: missing_return
                        onNotification: (notification){
                          if(notification is ScrollStartNotification)
                            {
                              _onScrollStart(notification.metrics);
                            }

                          if(notification is ScrollUpdateNotification)
                          {
                            _onScrollUpdate(notification.metrics);
                          }

                          if(notification is ScrollEndNotification)
                          {
                            _onScrollend(notification.metrics);
                          }
                        },
                        child: GridView.builder(
                          itemCount: categoriesList.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.70,
                            mainAxisSpacing: 0.3,
                            crossAxisSpacing: 20,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                                onLongPress: () {
                                  removeCategory(
                                      context, categoriesList[index].id);
                                },
                                child: Category(index));
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingButton() {
    return RaisedButton(
      onPressed: () {
        navigateAndKeepStack(context, AddCategory());
      },
      color: Colors.green,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Add Category',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 10),
          Icon(
            Icons.add,
            size: 25.0,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Widget Category(int index) {
    return GestureDetector(
      onTap: () {
        navigateAndKeepStack(context, CategoryProducts(categoriesList[index]));
      },
      child: Column(
        children: [
          Container(
            height: 180,
            width: 160,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(categoriesList[index].logo == null
                      ? "https://forums.oscommerce.com/uploads/monthly_2017_12/C_member_309126.png"
                      : dataBaseUrl + categoriesList[index].logo),
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${categoriesList[index].name}",
            style: TextStyle(color: greyColorXd, fontSize: 17),
          )
        ],
      ),
    );
  }

  Future<void> showMessageHud() async {
    XsProgressHud.showMessage(context, "Flutter app");
  }

  Future<void> showHud() async {
    XsProgressHud.show(context);
    Future.delayed(Duration(milliseconds: 2000)).then((val) {
      showMessageHud();
    });
  }
}
