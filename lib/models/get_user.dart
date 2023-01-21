import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('member');
    final user = FirebaseAuth.instance.currentUser!;
    const sizeboxsspace = SizedBox(height: 24);
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
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
                  SizedBox(
                    height: 50,
                    width: 329,
                    child: Card(
                      elevation: 2,
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "ชื่อ : " +
                                "${data['firstname']} ${data['lastname']}",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.kanit(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              sizeboxsspace,
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 329,
                    child: Card(
                      child: Center(
                        child: Container(
                          child: Text(
                            "อีเมล : " + user.email!,
                            style: GoogleFonts.kanit(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              sizeboxsspace,
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 329,
                    child: Card(
                      child: Center(
                        child: Text(
                          "เบอร์โทร : " + "${data['phone_number']}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.kanit(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              sizeboxsspace,
              Row(
                children: [
                  SizedBox(
                    height: 130,
                    width: 329,
                    child: Card(
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "ที่อยู่ \n" + "${data['address']}",
                            maxLines: 4,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.kanit(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        }
// Text("Full Name: ${data['full_name']} ${data['last_name']}");
        return CircularProgressIndicator();
      },
    );
  }
}
