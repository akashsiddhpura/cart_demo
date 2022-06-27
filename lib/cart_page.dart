import 'package:cart_demo/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  List<CartModel> finalCart;
  CartPage(this.finalCart);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var subTotal = 0;
  var shipping = 300;
  @override
  void initState() {
    for (int i = 0; i < widget.finalCart.length; i++) {
      int stotal = widget.finalCart[i].price * widget.finalCart[i].quantity;
      subTotal += stotal;

    }
    super.initState();
  }

  @override
  void dispose() {
    widget.finalCart.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.teal,
        ),
        title: Text(
          "Final Cart",
          style: TextStyle(color: Colors.teal),
        ),
        backgroundColor: Colors.white,
      ),
      body:
      widget.finalCart.length != 0 ?
      Container(
        height: 520,
        child: ListView.builder(
          itemCount: widget.finalCart.length,
          itemBuilder: (context, index) {
            return Card(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Positioned(
                      left: 280,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (widget.finalCart[index].quantity > 0) {
                                  widget.finalCart[index].quantity--;
                                  if (counter > 0) {
                                    counter--;
                                  }
                                  setState(() {
                                        print(widget.finalCart[index].quantity);
                                  });

                                  int stotal = widget.finalCart[index].price;
                                  subTotal -= stotal;
                                  setState(() {
                                    widget.finalCart;
                                  });
                                  if(widget.finalCart[index].quantity == 0){
                                    widget.finalCart.removeAt(index);
                                    setState(() {
                                      widget.finalCart;

                                    });
                                  }
                                }
                              });
                            },
                            child: Icon(Icons.remove_circle_rounded,color: Colors.teal.shade300,),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            width: 25,
                            child: Center(
                              child: Text(
                                widget.finalCart[index].quantity.toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (widget.finalCart[index].quantity < 98) {
                                  widget.finalCart[index].quantity++;
                                  if (counter < 98) {
                                    counter++;
                                  }
                                  int stotal = widget.finalCart[index].price;
                                  subTotal += stotal;

                                  setState(() {
                                    widget.finalCart;
                                  });
                                }
                              });
                            },
                            child: Icon(Icons.add_circle_rounded,color: Colors.teal.shade300,),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                widget.finalCart[index].image,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.finalCart[index].proName,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "₹${widget.finalCart[index].price}",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ) :
      Center(child: Text("Add product first"),),
      bottomSheet: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, -1), blurRadius: 30)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Subtotal"), Text("₹ ${subTotal}")],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Shipping Charge"),

                  Text("₹ ${shipping}")],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹ ${subTotal + shipping}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.teal.shade200,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 30)
                      ]),
                  child: Center(
                    child: Text(
                      "Check out",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
