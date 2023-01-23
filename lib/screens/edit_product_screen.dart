import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/edit_show_product.dart';
import '../models/list_product.dart';
import 'dashboard.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final produnctname = TextEditingController();
  final detail = TextEditingController();
  final price = TextEditingController();
  final amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const sizeboxspace = SizedBox(height: 24);
    const sizeboxcenter = SizedBox(width: 20);

    return Scaffold(
      appBar: AppBar(
        title: Text("แก้ไขสินค้า"),
        titleTextStyle: GoogleFonts.kanit(fontSize: 20),
        centerTitle: true,
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
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ShowsignleProduct('EHX20BbPLWDSlqtpY17q'),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      sizeboxspace,
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
                      sizeboxspace,
                      TextFormField(
                        validator: RequiredValidator(
                            errorText: "กรอกรายละเอียดสินค้า"),
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        controller: detail,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'รายละเอียดสินค้า',
                          filled: true,
                        ),
                      ),
                      sizeboxspace,
                      TextFormField(
                        validator:
                            RequiredValidator(errorText: "กรุณากรอกราคา"),
                        controller: price,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'ราคา',
                          filled: true,
                        ),
                      ),
                      sizeboxspace,
                      TextFormField(
                        validator: RequiredValidator(
                            errorText: "กรุณากรอกจำนวนสินค้า"),
                        controller: amount,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'คลัง',
                          filled: true,
                        ),
                      ),
                      sizeboxspace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              child: Text(
                                "ลบสินค้า",
                                style: GoogleFonts.kanit(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              onPressed: () {
                                // String docIds;
                                // Future getdocId() async {
                                //   await FirebaseFirestore.instance
                                //       .collection('product')
                                //       .get()
                                //       .then((snapshot) =>
                                //           snapshot.docs.forEach((document) {
                                //             print(document.reference);
                                //           }));
                                // }
                              },
                            ),
                          ),
                          sizeboxcenter,
                          SizedBox(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                              ),
                              child: Text(
                                "แก้ไขสินค้า",
                                style: GoogleFonts.kanit(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
