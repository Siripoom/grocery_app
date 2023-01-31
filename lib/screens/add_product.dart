import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/screens/dashboard.dart';

import 'home_screen.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final storageRef = FirebaseStorage.instance.ref();
  final formKey = GlobalKey<FormState>();
  final now = DateTime.now();
  @override
  PlatformFile? pickedFile;

  Future uploadFile() async {
    final path = 'product/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
    // *****ใช้ toast แจ้งว่าอัพโหลดสำเร็จ
    Fluttertoast.showToast(
        msg: "อัพโหลดรูปสำเร็จ", gravity: ToastGravity.CENTER);
  }

  Future selecetFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);

    final produnctname = TextEditingController();
    final detail = TextEditingController();
    final price = TextEditingController();
    final amount = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("เพิ่มสินค้า"),
        titleTextStyle: GoogleFonts.kanit(fontSize: 20),
        backgroundColor: Color.fromRGBO(54, 128, 45, 1.0),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Dashboard(); //เชื่อมโยงหน้าแอพ
                    },
                  ),
                )),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (pickedFile != null)
                  Container(
                    height: 150,
                    width: 120,
                    child: Image.file(
                      File(
                        pickedFile!.path!,
                      ),
                    ),
                  ),

                // Text(
                //   pickedFile!.name,
                // ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                      ),
                      child: Text(
                        "เลือกรูปส้นค้า",
                        style: GoogleFonts.kanit(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      onPressed: selecetFile,
                    ),
                    ElevatedButton(
                      child: Text(
                        "อัพโหลดรูปส้นค้า",
                        style: GoogleFonts.kanit(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      onPressed: uploadFile,
                    ),
                  ],
                ),
                sizedBoxSpace,
                TextFormField(
                  validator:
                      RequiredValidator(errorText: "กรุณากรอกชื่อสินค้า"),
                  controller: produnctname,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'ชื่อสินค้า',
                    filled: true,
                  ),
                ),
                sizedBoxSpace,
                TextFormField(
                  validator:
                      RequiredValidator(errorText: "กรอกรายละเอียดสินค้า"),
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  controller: detail,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'รายละเอียดสินค้า',
                    filled: true,
                  ),
                ),
                sizedBoxSpace,
                TextFormField(
                  validator: RequiredValidator(errorText: "กรุณากรอกราคา"),
                  controller: price,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'ราคา',
                    filled: true,
                  ),
                ),
                sizedBoxSpace,
                TextFormField(
                  validator:
                      RequiredValidator(errorText: "กรุณากรอกจำนวนสินค้า"),
                  controller: amount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'คลัง',
                    filled: true,
                  ),
                ),
                sizedBoxSpace,
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                  icon: Icon(
                    Icons.add_circle,
                    size: 32,
                  ),
                  label: Text(
                    "ลงขาย",
                    style: GoogleFonts.kanit(
                      fontSize: 24,
                    ),
                  ),
                  onPressed: () {
                    final fproductname = produnctname.text;
                    final fprice = price.text;
                    final famount = amount.text;
                    final fdetail = detail.text;

                    addProduct(
                      fproductname,
                      fprice,
                      famount,
                      fdetail,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future addProduct(productname, price, amount, detail) async {
    if (formKey.currentState!.validate()) {
      // แก้ error ค่า null ของ validator และ การตรวจสอบข้อมู ด้วย validator
      try {
        // Upload product image
        final path = 'product/${pickedFile!.name}';
        final file = File(pickedFile!.path!);

        final ref = FirebaseStorage.instance.ref().child(path);
        ref.putFile(file);
        // Initialize firebase
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp();
        // firebase Auth createUser

        // write data to firebase
        final docUser = FirebaseFirestore.instance.collection('product').doc();

        final json = {
          //'id': user.uid,
          'productname': productname,
          'price': price,
          'amount': amount,
          'detail': detail,
          'datetime': now.toString(),
          'image': await ref.getDownloadURL()
        };
        // create document and write data to firebase
        await docUser.set(json);

        Fluttertoast.showToast(
            msg: "เพิ่มสินค้าสำเร็จ", gravity: ToastGravity.CENTER);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen(); //เชื่อมโยงหน้าแอพ
            },
          ),
        );
      } on FirebaseException catch (e) {
        print(e.message);
      }

      // create document and write data to firebase
    }
  }
}
