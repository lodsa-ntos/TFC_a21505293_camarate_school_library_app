import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          'Bem-vindo',
          style: GoogleFonts.catamaran(
              fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
