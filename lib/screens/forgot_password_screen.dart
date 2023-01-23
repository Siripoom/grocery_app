import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/screens/login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const sizeboxspace = SizedBox(height: 24);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Reset Password",
          style: GoogleFonts.lato(fontSize: 20, color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Signinpage(); //เชื่อมโยงหน้าแอพ
                    },
                  ),
                )),
      ),
      backgroundColor: Color.fromRGBO(248, 248, 250, 1.0),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Receive an email to reset your password.",
                  style: GoogleFonts.lato(fontSize: 18),
                ),
                sizeboxspace,
                TextFormField(
                  //กำหนดรูปแบบแป้นพิมพ์ โดยการกำหนดที่ Attribute
                  keyboardType: TextInputType.emailAddress,
                  //ตรวจสอบความถูกต้อง validator
                  validator: MultiValidator([
                    RequiredValidator(errorText: "กรุณากรอกอีเมล"),
                    EmailValidator(errorText: "อีเมลไม่ถูกต้อง")
                  ]),
                  controller: email, //ตัวแปรรับค่าลง Controller

                  //กำหนดลักษณะของปุ่ม
                  decoration: const InputDecoration(
                    icon: Icon(FontAwesomeIcons.envelope),
                    border: UnderlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                sizeboxspace,
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: Color.fromRGBO(54, 128, 45, 1.0),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.envelope,
                    size: 32,
                  ),
                  label: Text(
                    "Reset Password",
                    style: GoogleFonts.kanit(
                      fontSize: 24,
                    ),
                  ),
                  onPressed: resetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    formKey.currentState!.validate();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => Center(
              child: CircularProgressIndicator(),
            )));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());

      Fluttertoast.showToast(
          msg: "Password Reset Email Sent.",
          fontSize: 24,
          gravity: ToastGravity.CENTER);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? 'default';
      Fluttertoast.showToast(msg: message, gravity: ToastGravity.CENTER);
      Navigator.of(context).pop(context);
    }
  }
}
