import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:grocery_app/screens/register_screen.dart';

void main() {
  runApp(myapp());
}

//สร้าง widget เอง
class myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery ',
      home: OptionScreen(),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}

class OptionScreen extends StatefulWidget {
  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 220);
    path.quadraticBezierTo(size.width / 4, 160 /*180*/, size.width / 2, 175);
    path.quadraticBezierTo(3 / 4 * size.width, 190, size.width, 130);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    const sizeboxspace = SizedBox(height: 17);
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 250, 1.0),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            sizeboxspace,
            SizedBox(
                height: 40,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(54, 128, 45, 1.0),
                  ),
                  // side: BorderSide(color: Colors.yellow, width: 5),
                  child: Text(
                    'Sign in',
                    style: GoogleFonts.lato(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Signinpage(); //เชื่อมโยงหน้าแอพ
                        },
                      ),
                    );
                  },
                )),
            sizeboxspace,
            SizedBox(
                height: 40,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(54, 128, 45, 1.0),
                  ),
                  child: Text(
                    'Sign up',
                    style: GoogleFonts.lato(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Register(); //เชื่อมโยงหน้าแอพ
                        },
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
