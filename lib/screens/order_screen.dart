import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/models/get_user.dart';
import 'package:grocery_app/models/productlist.dart';
import 'package:grocery_app/screens/cart.dart';
import 'package:grocery_app/screens/home_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final items = ['ปลายทาง', 'ชำระผ่านธนาคาร'];
  final now = DateTime.now();
  String? value;
  Widget build(BuildContext context) {
    // final String documentId;
    final user = FirebaseAuth.instance.currentUser!;
    const sizeboxsspace = SizedBox(height: 20);

    CollectionReference cart = FirebaseFirestore.instance.collection('bill');

    return FutureBuilder<DocumentSnapshot>(
      future: cart.doc(user.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Center(
            child: Text(
              "ไม่มีสินค้าในตะกร้า",
              style: GoogleFonts.kanit(
                  fontSize: 20, color: Color.fromRGBO(4, 32, 1, 1)),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          final product = ["${data['produtname']}"];
          //final price = "{$data['price']}";
          final amount = "{$data['amount']}";
          final total = "{$data['total']}";
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("ยืนยันการสั่งซื้อ"),
              titleTextStyle: GoogleFonts.kanit(fontSize: 20),
              backgroundColor: Color.fromRGBO(54, 128, 45, 1.0),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ShoppingCart(); //เชื่อมโยงหน้าแอพ
                          },
                        ),
                      )),
            ),
            body: Container(
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                  child: Center(
                child: Column(
                  children: [
                    GetUserName(user.uid),
                    sizeboxsspace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 130,
                          width: 329,
                          child: Card(
                            elevation: 2,
                            child: Center(
                              child: Container(
                                child: Text(
                                  "สินค้า : ${data['productname']} \n"
                                  "ราคา : ${data['price']}\n"
                                  "จำนวน : ${data['productname']} \n"
                                  "ราคาทั้งหมด : ${data['price']}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.kanit(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    sizeboxsspace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Color.fromRGBO(54, 128, 45, 1.0),
                            ),
                          ),
                          child: SizedBox(
                            height: 50,
                            width: 150,
                            child: DropdownButton<String>(
                              value: value,
                              items: items.map(buildMenuItem).toList(),
                              onChanged: (value) =>
                                  setState(() => this.value = value),
                            ),
                          ),
                        )
                      ],
                    ),
                    sizeboxsspace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [select_item(product, amount, total)],
                    )
                  ],
                ),
              )),
            ),
          );
        }
// Text("Full Name: ${data['full_name']} ${data['last_name']}");
        return CircularProgressIndicator();
      },
    );
  }

  Widget select_item(product, amount, total) {
    PlatformFile? pickedFile;
    Future uploadFile() async {
      final path = 'bills/${pickedFile!.name}';
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

    if (value == 'ชำระผ่านธนาคาร') {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(54, 128, 45, 1.0),
                ),
                child: Text(
                  "อัพโหลดสลิปการโอนเงิน",
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
          )
        ],
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(54, 128, 45, 1.0),
        ),
        child: Text(
          "สั่งสินค้า",
          style: GoogleFonts.kanit(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        onPressed: () {
          order(product, amount, total);
        },
      );
    }
  }

  Future order(product, amount, total) async {
    // Initialize firebase
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final user = FirebaseAuth.instance.currentUser!;
    //
    final docOrder =
        FirebaseFirestore.instance.collection('bill').doc(user.uid);

    final docUser =
        FirebaseFirestore.instance.collection('mammber').doc(user.uid).get();

    var snapshot;
    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
    final name = "${data['firstname']}";
    final json = {
      'name': name,
      'productname': product,
      'amount': amount,
      'total': total,
      'status': 'กำลังดำเนินการ',
      'datetime': now.toString(),
    };
    await docOrder.set(json);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen(); //เชื่อมโยงหน้าแอพ
        },
      ),
    );
    //return Text("Document does not exist");
  }
}

//write data to firebase

DropdownMenuItem<String> buildMenuItem(String items) => DropdownMenuItem(
      value: items,
      child: Text(
        items,
        style: GoogleFonts.kanit(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
