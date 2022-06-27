import 'package:badges/badges.dart';
import 'package:cart_demo/cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

var counter = 0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CartModel> ProductList = [
    CartModel("assets/shoes/s-1.jpg", "Nile air", 3500, 0, 0),
    CartModel("assets/shoes/s-2.jpg", "Nike Dunk Low", 4000, 0, 1),
    CartModel("assets/shoes/s-3.jpg", "Nile jordan", 3300, 0, 2),
    CartModel("assets/shoes/s-4.jpg", "Nile air max", 2500, 0, 3),
    CartModel("assets/shoes/s-5.jpg", "Puma", 5000, 0, 4),
    CartModel("assets/shoes/s-6.jpg", "Runner", 4500, 0, 5),
    CartModel("assets/shoes/s-7.jpg", "PG 6 EP", 3800, 0, 6),
    CartModel("assets/shoes/s-8.jpg", "red chief", 6700, 0, 7),
    CartModel("assets/shoes/s-9.jpg", "disco", 2000, 0, 8),
    CartModel("assets/shoes/s-10.jpg", "Air force", 5500, 0, 9),
    CartModel("assets/shoes/s-11.jpg", "chunky hill", 1200, 0, 10),
    CartModel("assets/shoes/s-12.jpg", "laufar", 1500, 0, 11),
  ];

  set(){
    if(mounted){
      setState(() {

      });
    }
  }

  Widget _shoppingCartBadge() {
    return
      counter != 0?
      Badge(
      position: BadgePosition.topEnd(top: 0, end: 3),
      // animationDuration: Duration(milliseconds: 1),
      animationType: BadgeAnimationType.fade,

      badgeContent: Text(
        counter > 99 ?
        "99+" :counter.toString(),
        style: TextStyle(color: Colors.white,fontSize: 10),
      ),
      child: IconButton(
        icon: Icon(
          Icons.shopping_cart_outlined,
          color: Colors.teal.shade300,
          size: 30,
        ),
        onPressed: () {
          setState(
            () async {
              for (int i = 0; i < ProductList.length; i++) {
                var item = ProductList[i];
                if (item.quantity > 0) {
                  addTocart.add(ProductList[i]);
                  print(addTocart);
                }
              }
              if (addTocart.length > 0) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(addTocart),
                  ),
                );
                set();
              }
            },
          );
        },
      ),
    ): IconButton(
        icon: Icon(
          Icons.shopping_cart_outlined,
          color: Colors.teal.shade300,
          size: 30,
        ),
        onPressed: () {
          Fluttertoast.showToast(
              msg: "Add product first",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.green);
        },
      );
  }

  List<CartModel> addTocart = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: Icon(
          Icons.menu,
          color: Colors.teal,
        ),
        title: Text(
          "Cart Demo",
          style: TextStyle(color: Colors.teal),
        ),
        backgroundColor: Colors.white,
        actions: [_shoppingCartBadge()],
      ),
      body: GridView.builder(
        itemCount: ProductList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2.5,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shadowColor: Colors.teal.shade300,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          ProductList[index].image,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    ProductList[index].proName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "₹${ProductList[index].price}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      )),
                      Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (ProductList[index].quantity > 0) {
                                    ProductList[index].quantity--;
                                    if (counter > 0) {
                                      counter--;
                                    }
                                  }
                                });
                              },
                              child: Icon(
                                Icons.remove_circle_rounded,
                                color: Colors.teal.shade300,
                              ),
                            ),
                            Container(
                                width: 25,
                                child: Center(
                                    child: Text(
                                  ProductList[index].quantity.toString(),
                                  style: TextStyle(fontSize: 18),
                                ))),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (ProductList[index].quantity < 99) {
                                    ProductList[index].quantity++;
                                      counter++;

                                    // if(ProductList[index].quantity > 0){
                                    //   addTocart.add(ProductList[index]);
                                    //   print(addTocart);
                                    // }
                                  }
                                });
                              },
                              child: Icon(
                                Icons.add_circle_rounded,
                                color: Colors.teal.shade300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CartModel {
   int idx;
   String image;
   String proName;
   int price;
   int quantity;

  CartModel(this.image, this.proName, this.price, this.quantity, this.idx);
}
