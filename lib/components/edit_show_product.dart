import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowsignleProduct extends StatelessWidget {
  final String documentId;

  ShowsignleProduct(this.documentId);

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
                width: 250,
                child: Row(
                  children: [
                    Image(
                      image: NetworkImage('${data['image']}'),
                      width: 80,
                      height: 80,
                    ),
                    Text(
                        "${data['productname']} " +
                            "ราคา " +
                            "${data['price']} บาท\n"
                                "คลัง ${data['amount']}", // โชวข้อมูลสินค้า พร้อมรูป , และเมื่อผู้ใช้กดที่สินค้าจะแสดง Bottomsheet พร้อมกับรายละเอียดสินค้า
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                            fontSize: 20, fontWeight: FontWeight.w400)),
                  ],
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
