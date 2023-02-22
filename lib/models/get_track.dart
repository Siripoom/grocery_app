import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/screens/history.dart';
import 'package:grocery_app/screens/order_screen.dart';
import 'package:grocery_app/screens/track_status.dart';

class GetTrack extends StatelessWidget {
  final String documentId;
  GetTrack(this.documentId);
  final sizeboxsspace = SizedBox(height: 20);
  final sizeboxminheight = SizedBox(height: 5);

  @override
  Widget build(BuildContext context) {
    CollectionReference track = FirebaseFirestore.instance.collection('bill');

    return Column(children: [
      FutureBuilder<DocumentSnapshot>(
        future: track.doc(documentId).get(),
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
                                  width: 120,

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
                                            color: Color.fromARGB(
                                                255, 67, 72, 160)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      sizeboxminheight,
                                      SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: FloatingActionButton(
                                          child: const Icon(
                                              FontAwesomeIcons.check),
                                          mini: false,
                                          backgroundColor:
                                              Colors.green.shade600,
                                          onPressed: (() {
                                            //final st = ${data['status']}

                                            receive();
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return TrackStatus(); //เชื่อมโยงหน้าแอพ
                                                },
                                              ),
                                            );
                                          }),
                                        ),
                                      )
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
                // ElevatedButton(
                //   child: Text(
                //     "สั่งสินค้า",
                //     style: GoogleFonts.kanit(
                //       fontSize: 20,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                //   onPressed: () {
                //     int famount = int.parse(amount.text);
                //     int fprice = int.parse(price);
                //     int total = famount * fprice;
                //     //order(productname, fprice, famount, total);
                //     Navigator.pushReplacement(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) {
                //           return OrderScreen(); //เชื่อมโยงหน้าแอพ
                //         },
                //       ),
                //     );
                //   },
                // ),
              ],
            );
          }

          return Center(child: CircularProgressIndicator());
        }),
      ),
    ]);
  }

  Future receive() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    // write data to firebase
    final cart = FirebaseFirestore.instance.collection('bill').doc(documentId);
    final json = {'status': "สำเร็จ"};
    // create document and write data to firebase
    await cart.update(json);
  }
}
