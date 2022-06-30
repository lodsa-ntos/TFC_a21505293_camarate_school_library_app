import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'info_da_app.dart';

class Sobre extends StatelessWidget {
  const Sobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: topoDaPaginaSobre(context),
      body: const InformacaoDaApp(),
    );
  }

  AppBar topoDaPaginaSobre(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/voltar.svg"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Sobre',
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
