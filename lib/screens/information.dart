import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/models/get_user.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import '../components/drawer_header.dart';
import '../components/drawer_item.dart';
import '../components/item_owner.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  final user = FirebaseAuth.instance.currentUser!;

  // get docIDs
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('member').doc(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ข้อมูลของฉัน"),
        titleTextStyle: GoogleFonts.kanit(fontSize: 20),
        backgroundColor: Color.fromRGBO(54, 128, 45, 1.0),
      ),
      backgroundColor: Color.fromRGBO(248, 248, 250, 1.0),
      drawer: drawer_chosen(),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            sizedBoxSpace,
            GetUserName(user.uid),
            sizedBoxSpace,
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                backgroundColor: Color.fromRGBO(54, 128, 45, 1.0),
              ),
              icon: Icon(
                Icons.arrow_back,
                size: 32,
              ),
              label: Text(
                "ออกจากระบบ",
                style: GoogleFonts.kanit(
                  fontSize: 24,
                ),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Signinpage(); //เชื่อมโยงหน้าแอพ
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget drawer_chosen() {
    if (user.uid != '2SywMWwl4DenaxBCk5fQPOSv6vE2') {
      return Drawer(
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
      );
    } else {
      return Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [Drawer_header(), DrawerItemOwner()],
            ),
          ),
        ),
      );
    }
  }
}
