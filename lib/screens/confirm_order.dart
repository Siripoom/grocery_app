import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/models/show_order.dart';
import 'package:grocery_app/screens/cart.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({super.key});

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey[800],
            ),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ShoppingCart(); //เชื่อมโยงหน้าแอพ
                    },
                  ),
                )),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: docIds.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: ShowMyOrder(docIds[index]),
              );
            },
          );
        },
      ),
    );
  }
}
