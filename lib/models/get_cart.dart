import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/screens/cart.dart';

import '../screens/cart.dart';

class GetCart extends StatelessWidget {
  String documentIds;
  GetCart(this.documentIds);
  final amount = TextEditingController();
  final sizeboxsspace = SizedBox(height: 20);
  final sizeboxminheight = SizedBox(height: 5);

  @override
  Widget build(BuildContext context) {
    CollectionReference cartlist =
        FirebaseFirestore.instance.collection('cart');

    return FutureBuilder<DocumentSnapshot>(
      future: cartlist.doc(documentIds).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          int price = int.parse("${data['price']}");

          final docId = "$data['product_id']";
          final productname = "${data['product_name']}";
          return Column(
            children: [
              sizeboxsspace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 130,
                    width: 329,
                    child: Card(
                      elevation: 3,
                      child: Container(
                        //color: Color.fromRGBO(182, 243, 150, 1),

                        // alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  '${data['image']}',
                                  width: 130,
                                  height: 80,
                                ),
                                Text(
                                  "${data['product_name']} $price บาท",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.lato(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(4, 32, 1, 1)),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 90,
                                  height: 60,
                                  child: TextFormField(
                                    controller: amount,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'จำนวน',
                                      filled: true,
                                    ),
                                  ),
                                ),
                                sizeboxminheight,
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: FloatingActionButton(
                                    child: const Icon(FontAwesomeIcons.minus),
                                    mini: false,
                                    backgroundColor:
                                        Color.fromRGBO(204, 54, 54, 1.0),
                                    onPressed: (() {
                                      delete();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ShoppingCart(); //เชื่อมโยงหน้าแอพ
                                          },
                                        ),
                                      );
                                    }),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                child: Text(
                  "สั่งสินค้า",
                  style: GoogleFonts.kanit(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  //print(productname);
                  //  order(productname, price, amount, total, value);
                },
              )
            ],
          );
        }

        return Center(child: CircularProgressIndicator());
      }),
    );
  }

  Future delete() async {
    // Initialize firebase
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    // write data to firebase
    final cart = FirebaseFirestore.instance.collection('cart').doc(documentIds);

    // create document and write data to firebase
    await cart.delete();

    Fluttertoast.showToast(
        msg: "เพิ่มสินค้าสำเร็จ", gravity: ToastGravity.CENTER);
  }
}

void order(productname, price, TextEditingController amount, total, value) {}
