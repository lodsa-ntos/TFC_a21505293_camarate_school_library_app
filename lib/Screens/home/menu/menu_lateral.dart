import 'package:camarate_school_library/Models/utilizador.dart';
import 'package:camarate_school_library/Screens/home/Menu/settings/configuracao.dart';
import 'package:camarate_school_library/Screens/login/login_screen.dart';
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
  Utilizador utilizadorLogado = Utilizador();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Utilizadores")
        .doc(utilizador!.uid)
        .get()
        .then((value) {
      utilizadorLogado = Utilizador.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // Identificação do utilizador
    final iconPerfilDoUtilizador = Row(
      children: [
        const CircleAvatar(),
        const SizedBox(width: 13),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${utilizadorLogado.nomeProprio} ${utilizadorLogado.ultimoNome}",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            Text(
              "${utilizadorLogado.email}",
              style: const TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
          ],
        )
      ],
    );

    // Conteudo do menu lateral
    final conteudo = Column(
      children: conteudoDoMenu
          .map((element) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      element['icone'],
                      color: Colors.white,
                      size: 23,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      element['titulo'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );

    // Definicoes e logout da app
    final definicoesELogout = Row(
      children: [
        const Icon(
          Icons.settings,
          color: Colors.white,
          size: 23,
        ),
        const SizedBox(width: 10),
        Text(
          'Definições',
          style: GoogleFonts.catamaran(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(width: 20),
        Container(
          width: 2,
          height: 20,
          color: Colors.white,
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            sair(context);
          },
          child: Text(
            'Sair',
            style: GoogleFonts.catamaran(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );

    return Container(
      color: Colors.blueAccent,
      padding: const EdgeInsets.only(top: 50, bottom: 70, left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Identificação do utilizador
          iconPerfilDoUtilizador,

          // Conteudo do menu lateral
          conteudo,

          // Definicoes e logout da app
          definicoesELogout,
        ],
      ),
    );
  }

  // Função sair da aplicação
  Future<void> sair(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
