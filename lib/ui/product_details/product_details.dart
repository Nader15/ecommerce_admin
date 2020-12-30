import 'package:ecommerce_admin/ApiFunctions/Api.dart';
import 'package:ecommerce_admin/model/add_to_cart_model.dart';
import 'package:ecommerce_admin/model/category_products_model.dart';
import 'package:ecommerce_admin/ui/cart.dart';
import 'package:ecommerce_admin/utils/colors_file.dart';
import 'package:ecommerce_admin/utils/navigator.dart';
import 'package:flutter/material.dart';

class CategoryDetails extends StatefulWidget {
  Data success;

  CategoryDetails(this.success);

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  AddToCartModel cart;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> scafoldState = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProductsModel productsModel;
  List<Data> categoryProductsList = List();

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
      Api(context).categoryProductsApi(_scaffoldKey).then((value) {
        productsModel = value;
        productsModel.success.data.forEach((element) {
          setState(() {
            categoryProductsList.add(element);
          });
        });
      });
    });
  }

  addToCartApi() {
    setState(() {
      Api(context).addToCart(_scaffoldKey).then((value) {
        productsModel = value;
        productsModel.success.data.forEach((element) {
          setState(() {
            categoryProductsList.add(element);
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldState,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        leading:IconButton(
          onPressed:(){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_backspace,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {
              navigateAndKeepStack(context, Cart());
            },
            icon: Icon(
              Icons.shopping_cart,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: categoryProductsList.length == 0
            ? Center(child: Container(child: Text("Loading data ..")))
            : Form(
          key: formKey,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context ,index){
                      return Body(index);
                    },
                  ),
                )
              ),
      ),
    );
  }

  Widget Body(int index) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 2.9),
            height: MediaQuery.of(context).size.height / 1.865,
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Category Name",
                  style: TextStyle(color: whiteColor),
                ),
                Text(
                  "${categoryProductsList[index].name}",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(text: "Price\n"),
                        TextSpan(
                            text: "\$${categoryProductsList[index].price}",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ]),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: Container(
                        height: 180,
                        width: 160,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://forums.oscommerce.com/uploads/monthly_2017_12/C_member_309126.png"),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CartCounter(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  child: Text(
                    "${categoryProductsList[index].description}",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Api(context)
                              .addToCart(scafoldState)
                              .then((value) {
                            if (value is AddToCartModel) {
                              cart = value;
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 50,
                          width: 58,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey)),
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.grey,
                            size: 25,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.green,
                            onPressed: () {},
                            child: Text(
                              "Buy Now",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

SizedBox buildOutLineButton(IconData icon, Function press) {
  return SizedBox(
    width: 40,
    height: 30,
    child: OutlineButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPressed: press,
      child: Icon(icon),
    ),
  );
}

class CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int noOfItems = 01;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildOutLineButton(
          Icons.remove,
          () {
            if (noOfItems > 1) {
              setState(() {
                noOfItems--;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(noOfItems.toString().padLeft(2, "0")),
        ),
        buildOutLineButton(
          Icons.add,
          () {
            setState(() {
              noOfItems++;
            });
          },
        ),
      ],
    );
  }
}
