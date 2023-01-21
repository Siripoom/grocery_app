import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/information.dart';
import 'package:grocery_app/screens/login_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../components/infopersonal.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    // final firstnameController = TextEditingController();
    // final lastnameController = TextEditingController();
    // final phonenumberController = TextEditingController();
    // final addressController = TextEditingController();
    // final uidController = TextEditingController();

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Sign up"),
      //   centerTitle: true,
      //   titleTextStyle: GoogleFonts.lato(fontSize: 20),
      // ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sizedBoxSpace,
                Text(
                  "Sign up",
                  style: GoogleFonts.lato(
                      fontSize: 25,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                sizedBoxSpace,
                TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: "กรุณากรอกอีเมล"),
                    EmailValidator(errorText: "อีเมลไม่ถูกต้อง")
                  ]),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Email',
                    icon: const Icon(FontAwesomeIcons.envelope),
                    filled: true,
                  ),
                ),
                sizedBoxSpace,
                TextFormField(
                  controller: passwordController,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "กรุณากรอกรหัสผ่าน"),
                    MinLengthValidator(8,
                        errorText: 'รหัสผ่านต้องมีความยาวอย่างน้อย 8 ตัวอักษร'),
                  ]),
                  obscureText: true,
                  decoration: const InputDecoration(
                    //icon: Icon(Icons.person),
                    border: UnderlineInputBorder(),

                    labelText: 'Password',
                    filled: true,
                    icon: const Icon(FontAwesomeIcons.lock),
                  ),
                ),
                sizedBoxSpace,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      child: Text(
                        "Next",
                        style: GoogleFonts.lato(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        // final firstname = firstnameController.text;
                        // final lastname = lastnameController.text;
                        // final uid = uidController.text;
                        // final address = addressController.text;
                        // final phonenumber = phonenumberController.text;
                        final email = emailController.text;
                        final password = passwordController.text;

                        signUp(email, password);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signUp(email, password) async {
    if (formKey.currentState!.validate()) {
      // showDialog(
      //   context: context,
      //   barrierDismissible: false,
      //   builder: (context) => Center(child: CircularProgressIndicator()),
      // );
      try {
        // Initialize firebase
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp();
        // firebase Auth createUser
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // write data to firebase
        // final docUser = FirebaseFirestore.instance.collection('member').doc();

        // final json = {
        //   'id': user.uid,
        //   'firstname': fname,
        //   'lastname': lname,
        //   'phone_number': phoneN,
        //   'address': address
        // };
        // // create document and write data to firebase
        // await docUser.set(json);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return InfoPersonal(); //เชื่อมโยงหน้าแอพ
            },
          ),
        );
      } on FirebaseAuthException catch (e) {
        print(e.message);
        Fluttertoast.showToast(
            msg: "Email นี้ถูกใช้งานเรียบร้อยแล้ว", gravity: ToastGravity.TOP);
      }

      // create document and write data to firebase

    }
  }
}
