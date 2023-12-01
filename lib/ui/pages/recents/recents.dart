import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Recents extends StatefulWidget {
  const Recents({super.key});

  @override
  State<Recents> createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recents",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
