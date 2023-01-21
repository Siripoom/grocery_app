import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/contactus.dart';
import '../screens/history.dart';
import '../screens/home_screen.dart';
import '../screens/information.dart';
import '../screens/track_status.dart';

class Drawer_header extends StatefulWidget {
  const Drawer_header({super.key});

  @override
  State<Drawer_header> createState() => _Drawer_headerState();
}

class _Drawer_headerState extends State<Drawer_header> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('member');

    return Container(
      color: Colors.green,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/Images/user.png"),
              ),
            ),
          ),
          Text(
            user.email!,
            // user.uis คือการดึงค่า uid มาแสดง
            style: GoogleFonts.lato(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
