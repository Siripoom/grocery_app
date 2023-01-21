import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/list_product.dart';

class ListProduct extends StatelessWidget {
  List<String> docIds = [];

  Future getdocId() async {
    await FirebaseFirestore.instance
        .collection('product')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIds.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: FutureBuilder(
          future: getdocId(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: docIds.length,
              itemBuilder: ((context, index) {
                return ListTile(title: ListsProduct(docIds[index]));
              }),
            );
          },
        ),
      ),
    );
  }
}
