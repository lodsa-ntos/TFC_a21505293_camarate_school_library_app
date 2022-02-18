import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/Models/utilizador.dart';
import 'package:camarate_school_library/Screens/Historico%20livro%20requisitado/historico.dart';
import 'package:camarate_school_library/Services/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: use_key_in_widget_constructors
class MenuLateral extends StatefulWidget {
  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  // User? utilizador = FirebaseAuth.instance.currentUser;
  Utilizador utilizadorLogado = Utilizador();

  //@override
  // void initState() {
  //  super.initState();
  //  FirebaseFirestore.instance
  //      .collection("Utilizadores")
  //      .doc(utilizador!.uid)
  //      .get()
  //     .then((value) {
  //    utilizadorLogado = Utilizador.fromMap(value.data());
  //    setState(() {});
  //  });
  // }

  List<Map> conteudoDoMenu = [];
  List<Livro> liv = [];

  @override
  void initState() {
    super.initState();
    conteudoDoMenu = [
      {
        'icone': Icons.history,
        'titulo': 'Historico',
        //'Redicionar Pagina': () => _redicionaParaPagina(Historico(liv)),
      },
      {
        'icone': FontAwesomeIcons.userAlt,
        'titulo': 'Perfil',
      },
      {
        'icone': Icons.notifications,
        'titulo': 'Notificação',
      },
    ];
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
    final conteudo = ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: conteudoDoMenu.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: conteudoDoMenu[index]['Redicionar Pagina'],
          leading: Icon(
            conteudoDoMenu[index]['icone'],
            color: Colors.white,
            size: 25,
          ),
          title: Text(
            conteudoDoMenu[index]['titulo'],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox();
      },
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
            //sair(context);
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
  // Future<void> sair(BuildContext context) async {
  //  await FirebaseAuth.instance.signOut();
  //  Navigator.of(context).pushReplacement(
  //      MaterialPageRoute(builder: (context) => const LoginScreen()));
  //}
}
