import 'package:camarate_school_library/Authentication/Login/login_screen.dart';
import 'package:camarate_school_library/Authentication/Models/modelo_utilizador.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: use_key_in_widget_constructors
class MenuLateral extends StatefulWidget {
  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  User? utilizador = FirebaseAuth.instance.currentUser;
  ModeloUtilizador utilizadorLogado = ModeloUtilizador();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Utilizadores")
        .doc(utilizador!.uid)
        .get()
        .then((value) {
      utilizadorLogado = ModeloUtilizador.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      padding: const EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${utilizadorLogado.nomeProprio} ${utilizadorLogado.ultimoNome}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${utilizadorLogado.email}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Definições',
                style: GoogleFonts.catamaran(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 2,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  sair(context);
                },
                child: Text(
                  'Sair',
                  style: GoogleFonts.catamaran(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // the logout function
  Future<void> sair(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PaginaLogin()));
  }
}
