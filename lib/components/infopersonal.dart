import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/login_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class InfoPersonal extends StatefulWidget {
  const InfoPersonal({super.key});

  @override
  State<InfoPersonal> createState() => _InfoPersonalState();
}

class _InfoPersonalState extends State<InfoPersonal> {
  final user = FirebaseAuth.instance.currentUser!;
  final formKey = GlobalKey<FormState>();
  final now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);
    final firstnameController = TextEditingController();
    final lastnameController = TextEditingController();
    final phonenumberController = TextEditingController();
    final addressController = TextEditingController();
    final uidController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
        centerTitle: true,
        titleTextStyle: GoogleFonts.lato(fontSize: 20),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                  validator: RequiredValidator(errorText: "กรุณากรอกชื่อ"),
                  controller: firstnameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Firstname',
                    filled: true,
                  ),
                ),
                sizedBoxSpace,
                TextFormField(
                  controller: lastnameController,
                  validator: RequiredValidator(errorText: "กรุณากรอกนามสกุล"),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Lastname',
                    filled: true,
                  ),
                ),
                sizedBoxSpace,
                TextFormField(
                  validator:
                      RequiredValidator(errorText: "กรุณากรอกเบอร์โทรศัพท์"),
                  controller: phonenumberController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Phonenumber',
                    icon: const Icon(Icons.phone),
                    filled: true,
                  ),
                ),
                sizedBoxSpace,
                TextFormField(
                  validator: RequiredValidator(errorText: "กรุณากรอกที่อยู่"),
                  controller: addressController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Address',
                    filled: true,
                  ),
                ),
                sizedBoxSpace,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.lato(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        final firstname = firstnameController.text;
                        final lastname = lastnameController.text;
                        final uid = uidController.text;
                        final address = addressController.text;
                        final phonenumber = phonenumberController.text;

                        signUp(firstname, lastname, uid, address, phonenumber);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signUp(fname, lname, uid, address, phoneN) async {
    if (formKey.currentState!.validate()) {
      try {
        // Initialize firebase
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp();
        // firebase Auth createUser

        // write data to firebase
        final docUser =
            FirebaseFirestore.instance.collection('member').doc(user.uid);

        final json = {
          //'id': user.uid,
          'firstname': fname,
          'lastname': lname,
          'phone_number': phoneN,
          'address': address,
          'datetime': now.toString()
        };
        // create document and write data to firebase
        await docUser.set(json);
        //Notification Toast
        Fluttertoast.showToast(
            msg: "สมัครสมาชิกสำเร็จ", gravity: ToastGravity.CENTER);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen(); //เชื่อมโยงหน้าแอพ
            },
          ),
        );
      } on FirebaseAuthException catch (e) {
        print(e.message);
      }

      // create document and write data to firebase

    }
  }
}
