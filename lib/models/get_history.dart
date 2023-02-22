import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class GetHistory extends StatelessWidget {
  String documentId;
  GetHistory(this.documentId);

  final sizeboxsspace = SizedBox(height: 20);
  final sizeboxminheight = SizedBox(height: 5);

  @override
  Widget build(BuildContext context) {
    CollectionReference history = FirebaseFirestore.instance.collection('bill');

    return Column(children: [
      FutureBuilder<DocumentSnapshot>(
        future: history.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            final amount = TextEditingController();
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
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  // color: Color.fromRGBO(182, 243, 150, 1),
                                  //margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        '${data['image']}',
                                        width: 130,
                                        height: 80,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 170,

                                  // margin: EdgeInsets.only(left: 20, right: 20),

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "สินค้า ${data['productname']} ",
                                        style: GoogleFonts.notoSerif(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(4, 32, 1, 1)),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "จำนวน ${data['amount']}",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.kanit(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey.shade600),
                                          ),
                                          Text(
                                            " ราคา ${data['total']}",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.kanit(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey.shade600),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${data['status']}",
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.kanit(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green.shade600),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          return Center(child: CircularProgressIndicator());
        }),
      ),
    ]);
  }
}
