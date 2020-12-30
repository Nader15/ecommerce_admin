import 'package:ecommerce_admin/utils/colors_file.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        leading: Icon(
          Icons.keyboard_backspace,
          color: greyColorXd,
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(
              Icons.search,
              color: greyColorXd,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: greyColorXd,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categories",
              style: TextStyle(
                  color: blackColor, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.70,
                  mainAxisSpacing: 0.3,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return ItemCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
   final Function press;

  const ItemCard({Key key, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            height: 180,
            width: 160,
            decoration: BoxDecoration(
                color:Colors.green,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage("https://forums.oscommerce.com/uploads/monthly_2017_12/C_member_309126.png"),
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "product.title",
            style: TextStyle(color: greyColorXd, fontSize: 17),
          )
        ],
      ),
    );
  }
}
