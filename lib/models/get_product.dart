import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html';

class GetProduct extends StatelessWidget {
  final String documentId;

  GetProduct(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('product');
    //final user = FirebaseAuth.instance.currentUser!;
    const sizeboxsspace = SizedBox(height: 24);
    PlatformFile? pickedFile;
    final storageRef = FirebaseStorage.instance.ref();

    return FutureBuilder<DocumentSnapshot>(
      future: products.doc(documentId).get(),
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
          // String img =  ${data['image']};
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 175,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            sizeboxsspace,
                            Image(
                              image: NetworkImage('${data['image']}'),
                              height: 300,
                              width: 350,
                            ),
                            sizeboxsspace,
                            Text(
                                "${data['productname']}" +
                                    "      " +
                                    "ราคา " +
                                    "${data['price']} บาท", // โชวข้อมูลสินค้า พร้อมรูป , และเมื่อผู้ใช้กดที่สินค้าจะแสดง Bottomsheet พร้อมกับรายละเอียดสินค้า
                                textAlign: TextAlign.start,
                                style: GoogleFonts.lato(
                                    fontSize: 20, fontWeight: FontWeight.w700)),
                            sizeboxsspace,
                            ElevatedButton(
                              child: Text(
                                "เพิ่มลงตะกร้า",
                                style: GoogleFonts.kanit(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            sizeboxsspace,
                          ],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: NetworkImage('${data['image']}'),
                          width: 120,
                          height: 80,
                        ),
                        Text(
                            "${data['productname']}\n" +
                                "ราคา " +
                                "${data['price']} บาท", // โชวข้อมูลสินค้า พร้อมรูป , และเมื่อผู้ใช้กดที่สินค้าจะแสดง Bottomsheet พร้อมกับรายละเอียดสินค้า
                            textAlign: TextAlign.center,
                            style: GoogleFonts.kanit(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                ),
              ),

              // NetworkImage('image')
            ],
          ));
        }
// Text("Full Name: ${data['full_name']} ${data['last_name']}");
        return CircularProgressIndicator();
      },
    );
  }
}
