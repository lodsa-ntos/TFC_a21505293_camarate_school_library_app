import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/ajuda.dart';
import 'components/perguntas_e_respostas.dart';

class CentroDeAjuda extends StatelessWidget {
  const CentroDeAjuda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: topoDaPaginaAjuda(context),
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
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
