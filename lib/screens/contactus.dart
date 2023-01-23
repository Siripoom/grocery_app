import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/drawer_header.dart';
import '../components/drawer_item.dart';

class Contactus extends StatefulWidget {
  const Contactus({super.key});

  @override
  State<Contactus> createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  final sizedBoxSpace = SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ติดต่อร้านค้า"),
        centerTitle: true,
        titleTextStyle: GoogleFonts.kanit(fontSize: 20),
        backgroundColor: Color.fromRGBO(54, 128, 45, 1.0),
      ),
      backgroundColor: Color.fromRGBO(248, 248, 250, 1.0),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/Images/logo-color.png"),
                ),
              ),
            ),
            Card(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ที่อยู่",
                        style: GoogleFonts.kanit(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "123/1 ม.1 ต.หน้าเมือง อ.เมือง จ.ราชบุรี",
                        style: GoogleFonts.kanit(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            sizedBoxSpace,
            Card(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "เบอร์โทร",
                        style: GoogleFonts.kanit(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "081-123-4567",
                        style: GoogleFonts.kanit(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            sizedBoxSpace,
            Card(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ไอดีไลน์",
                        style: GoogleFonts.kanit(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "081-123-4567",
                        style: GoogleFonts.kanit(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
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
      ),
    );
  }
}
