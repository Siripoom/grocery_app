import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class GetProduct extends StatelessWidget {
  final String documentId;

  GetProduct(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('product');
    //final user = FirebaseAuth.instance.currentUser!;
    const sizeboxsspace = SizedBox(height: 24);
    PlatformFile? pickedFile;
    final storageRef = FirebaseStorage.instance.ref();
    int number = 0;

    return FutureBuilder<DocumentSnapshot>(
      future: products.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          // String img =  ${data['image']};
          var productname = "${data['productname']}";
          int price = int.parse("${data['price']}");
          var image = '${data['image']}';
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 170,
                width: 175,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            sizeboxsspace,
                            Image(
                              image: NetworkImage(image),
                              height: 300,
                              width: 350,
                            ),
                            sizeboxsspace,
                            Text(
                                productname +
                                    "      " +
                                    "???????????? " +
                                    '$price' +
                                    " ?????????", // ????????????????????????????????????????????? ???????????????????????? , ????????????????????????????????????????????????????????????????????????????????????????????? Bottomsheet ????????????????????????????????????????????????????????????????????????
                                textAlign: TextAlign.start,
                                style: GoogleFonts.lato(
                                    fontSize: 20, fontWeight: FontWeight.w700)),
                            // sizeboxsspace,
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     FloatingActionButton(
                            //       child: const Icon(FontAwesomeIcons.minus),
                            //       onPressed: () {},
                            //     ),
                            //     Text(
                            //       '$number',
                            //       style: GoogleFonts.lato(fontSize: 30),
                            //     ),
                            //     FloatingActionButton(
                            //       child: const Icon(FontAwesomeIcons.plus),
                            //       onPressed: () {},
                            //     ),
                            //   ],
                            // ),
                            sizeboxsspace,
                            ElevatedButton(
                              child: Text(
                                "???????????????????????????????????????",
                                style: GoogleFonts.kanit(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              onPressed: () {
                                addtoCart(productname, price, image);
                                Navigator.pop(context);
                              },
                            ),
                            sizeboxsspace,
                          ],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: NetworkImage('${data['image']}'),
                          width: 120,
                          height: 80,
                        ),
                        Text(
                            "${data['productname']}\n" +
                                "???????????? " +
                                "${data['price']} ?????????", // ????????????????????????????????????????????? ???????????????????????? , ????????????????????????????????????????????????????????????????????????????????????????????? Bottomsheet ????????????????????????????????????????????????????????????????????????
                            textAlign: TextAlign.center,
                            style: GoogleFonts.kanit(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                ),
              ),

              // NetworkImage('image')
            ],
          ));
        }
// Text("Full Name: ${data['full_name']} ${data['last_name']}");
        return CircularProgressIndicator();
      },
    );
  }

  Future addtoCart(productname, price, image) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final user = FirebaseAuth.instance.currentUser;

      // firebase Auth createUser

      // write data to firebase
      final addcart = FirebaseFirestore.instance.collection('cart').doc();

      final json = {
        'member': user?.uid,
        'product_Id': documentId,
        'product_name': productname,
        'price': price,
        'image': image,
        // 'price': price,
        // 'amount': amount,
        // 'detail': detail,
        // 'datetime': now.toString(),
        // 'image': await ref.getDownloadURL()
      };
      // create document and write data to firebase
      await addcart.set(json);
      Fluttertoast.showToast(
          msg: "???????????????????????????????????????????????????", gravity: ToastGravity.CENTER);
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
