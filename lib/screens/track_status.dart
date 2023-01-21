import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/drawer_header.dart';
import '../components/drawer_item.dart';

class TrackStatus extends StatefulWidget {
  const TrackStatus({super.key});

  @override
  State<TrackStatus> createState() => _TrackStatusState();
}

class _TrackStatusState extends State<TrackStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สถานะสินค้า"),
        centerTitle: true,
        titleTextStyle: GoogleFonts.kanit(fontSize: 20),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Drawer_header(),
                DrawerItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
