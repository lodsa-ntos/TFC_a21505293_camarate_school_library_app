import 'package:camarate_school_library/Screens/home/components/construir_interface_home.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../pesquisar/pesquisar.dart';

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LivroRequisitadoModel>(
      builder: (context, requisitadoModel, child) {
        return Container(
          decoration: corGradienteDaPagina,

          //
          child: Scaffold(
            appBar: construirBarraDaAplicacao(context),

            backgroundColor: Colors.transparent,

            //* CONSTRUIR INTERFACE PARA O UTILIZADOR
            body: const ConstruirInterfaceHome(),
          ),
        );
      },
    );
  }
}

AppBar construirBarraDaAplicacao(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: Column(
      children: [
        const SizedBox(height: 2.0),
        Material(
          type: MaterialType.transparency,
          child: Column(
            children: [
              Text(
                'Biblioteca Escolar',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              Text(
                'Camarate',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    ),

    // Abrir menu lateral
    leading: Padding(
      padding: const EdgeInsets.only(left: 5.0, top: 15),
      child: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/menu.svg',
        ),
        onPressed: () => ZoomDrawer.of(context)?.open(),
      ),
    ),

    backgroundColor: Colors.transparent,

    elevation: 0,

    // Pesquisa
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 5.0, top: 15),
        child: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/pesquisa.svg',
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                //** Redireciona o utilizador para a página de detalhes do livro */
                builder: (context) => const PesquisaDeLivro(),
              ),
            );
          },
        ),
      ),
    ],
  );
}

const corGradienteDaPagina = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white,
      Color.fromRGBO(239, 241, 248, 1),
    ],
  ),
);

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
