import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/components/cardproduct.dart';

import 'package:grocery_app/components/drawer_header.dart';
import 'package:grocery_app/components/drawer_item.dart';
import 'package:grocery_app/components/item_owner.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/screens/contactus.dart';
import 'package:grocery_app/screens/history.dart';
import 'package:grocery_app/screens/information.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:grocery_app/screens/register_screen.dart';
import 'package:grocery_app/screens/track_status.dart';

import 'cart.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ร้านขายของชำ"),
        titleTextStyle: GoogleFonts.kanit(fontSize: 20),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.cartShopping),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ShoppingCart(); //เชื่อมโยงหน้าแอพ
                  },
                ),
              );
            },
          )
        ],
        backgroundColor: Color.fromRGBO(54, 128, 45, 1.0),
      ),
      backgroundColor: Color.fromRGBO(248, 248, 250, 1.0),
      body: CardProduct(),
      drawer: drawer_chosen(),
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
