import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowMyOrder extends StatelessWidget {
  final String documentId;

  ShowMyOrder(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference order = FirebaseFirestore.instance.collection('cart');

    return FutureBuilder<DocumentSnapshot>(
      future: order.doc(documentId).get(),
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

          return Column(
            children: [
              Row(
                children: [
                  Text(
                    "${data['product_name']}   ${data['price']}",
                    style: GoogleFonts.notoSerif(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}
