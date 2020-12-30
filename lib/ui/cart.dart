import 'package:ecommerce_admin/ApiFunctions/Api.dart';
import 'package:ecommerce_admin/model/cart_content_model.dart';
import 'package:ecommerce_admin/utils/colors_file.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CartContentModel cartContentModel;
  List<Success> cartList = List();

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
      Api(context).cartContent(_scaffoldKey).then((value) {
        cartContentModel = value;
        cartContentModel.success.forEach((element) {
          setState(() {
            cartList.add(element);
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.grey,
          elevation: 0,
          leading: IconButton(
            onPressed:(){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_backspace,
            ),
          ),
         title: Text("Cart"),
          centerTitle: true,
        ),
        body: Container(
          child:  cartList.length==0
              ? Center(
            child: Container(
              child: Text("No data found"),
            ),
          )
              : Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                itemCount: cartList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: .5,
                ),
                itemBuilder: (context, index) {
                  return CartList(index);
                },
              ),
            ),
          ),
        ));
  }

  Widget CartList(int index) {
    return ListTile(
      onTap: () {},
      leading: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: NetworkImage(
                  "https://forums.oscommerce.com/uploads/monthly_2017_12/C_member_309126.png"),
              fit: BoxFit.cover,
            )),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${cartList[index].product.name}",
            style: TextStyle(fontSize: 18, color: blackColor),
          ),
          Row(
            children: [
              Text(
                "Amount ",
                style: TextStyle(fontSize: 18, color: blackColor),
              ),
              Text(
                "(${cartList[index].amount})",
                style: TextStyle(fontSize: 20, color: blackColor),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Price ",
                style: TextStyle(fontSize: 18, color: blackColor),
              ),
              Text(
                "\$${cartList[index].product.price}",
                style: TextStyle(fontSize: 20, color: blackColor),
              ),
            ],
          ),
        ],
      ),
      trailing: Container(
        height: 40,
        width: 48,
        child: IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.remove_circle_outline,
            color: redColor,
            size: 25,
          ),
        )
      ),
    );
  }
}
