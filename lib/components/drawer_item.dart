import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/screens/cart.dart';

import '../screens/contactus.dart';
import '../screens/history.dart';
import '../screens/home_screen.dart';
import '../screens/information.dart';
import '../screens/track_status.dart';

class DrawerItem extends StatefulWidget {
  const DrawerItem({super.key});

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  var currentPage = DrawerSection.home;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // List item menu of menu drawer
        children: [
          menuItem(1, "หน้าหลัก", Icons.home_outlined,
              currentPage == DrawerSection.home ? true : false),
          menuItem(2, "ข้อมูลของฉัน", Icons.person_outlined,
              currentPage == DrawerSection.information ? true : false),
          menuItem(6, "ตะกร้าสินค้า", Icons.shopping_cart_outlined,
              currentPage == DrawerSection.cart ? true : false),
          menuItem(3, "ติดตามสถานะ", Icons.local_shipping_outlined,
              currentPage == DrawerSection.track_status ? true : false),
          menuItem(4, "ประวัติการสั่งซื้อ", Icons.shopping_basket_outlined,
              currentPage == DrawerSection.history ? true : false),
          menuItem(5, "ติดต่อร้านต้า", Icons.contact_support_outlined,
              currentPage == DrawerSection.contactus ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          if (id == 1) {
            currentPage = DrawerSection.home;
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }));
          } else if (id == 2) {
            currentPage = DrawerSection.information;
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Information();
            }));
          } else if (id == 3) {
            currentPage = DrawerSection.track_status;
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return TrackStatus();
            }));
          } else if (id == 4) {
            currentPage = DrawerSection.history;
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return History();
            }));
          } else if (id == 5) {
            currentPage = DrawerSection.contactus;
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Contactus();
            }));
          } else if (id == 6) {
            currentPage = DrawerSection.cart;
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return ShoppingCart();
            }));
          }
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(icon, size: 28, color: Colors.black),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: GoogleFonts.kanit(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSection {
  home,
  information,
  track_status,
  history,
  contactus,
  cart,
}
