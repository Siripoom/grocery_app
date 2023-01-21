import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signinpage extends StatefulWidget {
  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>(); //กำหนดรูปแบบแป้นพิมพ์และ FormKey
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    navigatorKey;
    const sizedBoxSpace = SizedBox(height: 24);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in"),
        centerTitle: true,
        titleTextStyle: GoogleFonts.lato(fontSize: 20),
      ),
      body: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sizedBoxSpace,
                  Text(
                    "Sign in",
                    style: GoogleFonts.lato(
                        fontSize: 25,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  sizedBoxSpace,
                  TextFormField(
                    //กำหนดรูปแบบแป้นพิมพ์ โดยการกำหนดที่ Attribute
                    keyboardType: TextInputType.emailAddress,
                    //ตรวจสอบความถูกต้อง validator
                    validator: MultiValidator([
                      RequiredValidator(errorText: "กรุณากรอกอีเมล"),
                      EmailValidator(errorText: "อีเมลไม่ถูกต้อง")
                    ]),
                    controller: emailController, //ตัวแปรรับค่าลง Controller

                    //กำหนดลักษณะของปุ่ม
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      border: UnderlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  sizedBoxSpace,
                  TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: "กรุณากรอกรหัสผ่าน"),
                    ]),
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.password),
                      border: UnderlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  sizedBoxSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: OutlinedButton(
                          child: Text(
                            "Sign up",
                            style: GoogleFonts.lato(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Register(); //เชื่อมโยงหน้าแอพ
                            }));
                          },
                        ),
                      ),
                      SizedBox(
                        child: ElevatedButton(
                          child: Text(
                            "Sign in",
                            style: GoogleFonts.lato(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          onPressed: signIn,
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return HomeScreen(); //เชื่อมโยงหน้าแอพ
                          // }));
                        ),
                      ),
                    ],
                  )
                ],
              ))),
    );
  }

  Future signIn() async {
    if (formKey.currentState!.validate()) {
      try {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp();
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        formKey.currentState?.reset();
        Fluttertoast.showToast(
            msg: "ลงชื่อเข้าใช้สำเร็จ", gravity: ToastGravity.CENTER);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen(); //เชื่อมโยงหน้าแอพ
            },
          ),
        );
      } on FirebaseAuthException catch (e) {
        String message = e.message ?? 'default';
        Fluttertoast.showToast(msg: message, gravity: ToastGravity.CENTER);
      }
      // navigatorKey.currentState!.popUntil((route) => route.isFirst);

    }
  }
}
