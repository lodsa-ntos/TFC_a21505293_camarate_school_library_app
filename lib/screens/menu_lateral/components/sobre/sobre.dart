import 'package:camarate_school_library/Models/view_models/conetividade.dart';
import 'package:camarate_school_library/Screens/sem_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'info_da_app.dart';

class _SobreState extends State<Sobre> {
  @override
  void initState() {
    super.initState();
    Provider.of<Conectividade>(context, listen: false).verificarLigacao();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Conectividade>(
      builder: (context, utilizador, child) {
        if (utilizador.isOnline != null) {
          return utilizador.isOnline ?? false
              ? Scaffold(
                  backgroundColor: Colors.white,
                  appBar: topoDaPaginaSobre(context),
                  body: const InformacaoDaApp(),
                )
              : SemInternet();
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
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
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}

class Sobre extends StatefulWidget {
  const Sobre({Key? key}) : super(key: key);

  @override
  State<Sobre> createState() => _SobreState();
}
