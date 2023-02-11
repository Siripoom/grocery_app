import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/components/list_cart.dart';
import 'package:grocery_app/models/get_cart.dart';

import '../components/drawer_header.dart';
import '../components/drawer_item.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  int amount = 1;
  final now = DateTime.now();
  final items = ['ปลายทาง', 'ชำระผ่านธนาคาร'];
  final sizeboxsspace = SizedBox(height: 20);
  List<String> docIds = [];

  String? value;
  Future getData() async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('cart')
        .where('member', isEqualTo: user.uid)
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              print(element.reference);
              docIds.add(element.reference.id);
            }));
  }

  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ตะกร้าสินค้า"),
        centerTitle: true,
        titleTextStyle: GoogleFonts.kanit(
          fontSize: 20,
        ),
        backgroundColor: Color.fromRGBO(54, 128, 45, 1.0),
      ),
      body: Container(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: docIds.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: GetCart(docIds[index]),
                );
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Drawer_header(),
                DrawerItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future order(productName, price, amount, total, items) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final user = FirebaseAuth.instance.currentUser!;
    // write data to firebase
    final userBill =
        FirebaseFirestore.instance.collection('bill').doc(user.uid);

    final json = {
      //'id': user.uid,
      'productname': productName,
      'price': price,
      'amount': amount,
      'total': total,
      'status': 'กำลังดำเนินการ',
      'paymentmethod': items,
      'datetime': now.toString(),
    };
    // create document and write data to firebase
    await userBill.set(json);
  }

  DropdownMenuItem<String> buildMenuItem(String items) => DropdownMenuItem(
        value: items,
        child: Text(
          items,
          style: GoogleFonts.kanit(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      );
  // Future cart(docIds) async {
  //   CollectionReference cartlist =
  //       FirebaseFirestore.instance.collection('cart');

  //   FutureBuilder<DocumentSnapshot>(
  //     future: cartlist.doc(docIds).get(),
  //     builder: ((context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         Map<String, dynamic> data =
  //             snapshot.data!.data() as Map<String, dynamic>;
  //         return Text('${data['product_name']}');
  //       }
  //       return Text('Loading..');
  //     }),
  //   );
  // }
}
