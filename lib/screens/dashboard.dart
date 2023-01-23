import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/components/item_owner.dart';
import 'package:grocery_app/components/listproduct.dart';
import 'package:grocery_app/screens/add_product.dart';
import 'package:grocery_app/screens/login_screen.dart';

import '../components/drawer_header.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    const sizeboxspace = SizedBox(height: 24);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dashboard"),
        titleTextStyle: GoogleFonts.kanit(fontSize: 20),
        backgroundColor: Color.fromRGBO(54, 128, 45, 1.0),
      ),
      body: Container(
        //child: SingleChildScrollView(
        margin: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        child: Column(
          children: [
            Container(
              // margin: const EdgeInsets.only(
              //     left: 145.0, right: 20.0, top: 20, bottom: 20),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text(
                      "สถานะคำสั่งซื้อ",
                      textAlign: TextAlign.end,
                      style: GoogleFonts.kanit(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // height: 50,
              // width: MediaQuery.of(context).size.width - 100,
              children: [
                Column(
                  children: [
                    Container(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(54, 128, 45, 1.0),
                        ),
                        child: Text(
                          "ที่ต้องจัดส่ง",
                          style: GoogleFonts.kanit(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        child: Text(
                          "ที่ถูกยกเลิก",
                          style: GoogleFonts.kanit(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ],
            ),
            sizeboxspace,
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(54, 128, 45, 1.0),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            // sizeboxspace,
            // Column(
            //   children: [],
            // ),
            sizeboxspace,
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                backgroundColor: Color.fromRGBO(54, 128, 45, 1.0),
              ),
              icon: Icon(
                Icons.add_circle,
                size: 32,
              ),
              label: Text(
                "เพิ่มสินค้า",
                style: GoogleFonts.kanit(
                  fontSize: 24,
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddProduct(); //เชื่อมโยงหน้าแอพ
                    },
                  ),
                );
              },
            ),
            ListProduct()
          ],
        ),
        //),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Drawer_header(),
                DrawerItemOwner(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
