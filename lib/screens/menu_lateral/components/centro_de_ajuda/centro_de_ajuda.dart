import 'package:camarate_school_library/Models/ajuda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/perguntas_e_respostas.dart';

class CentroDeAjuda extends StatelessWidget {
  const CentroDeAjuda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // barra da página
      appBar: topoDaPaginaAjuda(context),

      // Lista para carregar as perguntas e repostas
      body: ListView.builder(
        itemCount: perguntasERespostas.length,
        itemBuilder: (BuildContext context, int index) => PerguntasERespostas(
          perguntasERespostas[index],
        ),
      ),
    );
  }

  AppBar topoDaPaginaAjuda(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/voltar.svg"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Centro de ajuda',
        style: TextStyle(
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.headline6!.color,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
