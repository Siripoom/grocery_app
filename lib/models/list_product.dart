import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/screens/edit_product_screen.dart';

class ListsProduct extends StatelessWidget {
  final String documentId;

  ListsProduct(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference product =
        FirebaseFirestore.instance.collection('product');

    return FutureBuilder<DocumentSnapshot>(
      future: product.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Container(
            height: 50,
            margin: EdgeInsets.only(top: 5),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditProductScreen(); //เชื่อมโยงหน้าแอพ
                    },
                  ),
                );
              },
              child: Card(
                elevation: 2,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "  ${data['productname']} |",
                          style: GoogleFonts.kanit(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " คลัง ${data['amount']} ",
                          style: GoogleFonts.kanit(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}
