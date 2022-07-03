import 'package:camarate_school_library/Models/view_models/conetividade.dart';
import 'package:camarate_school_library/Screens/sem_internet.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';
import 'package:camarate_school_library/screens/detalhes_do_livro/components/capa_do_livro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class _LivroDetalhadoState extends State<LivroDetalhado> {
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
              ? Consumer<LivroRequisitadoModel>(
                  builder: (context, requisitadoModel, child) {
                    return Scaffold(
                      //
                      appBar: contruirAppBarLivroDetalhado(context),

                      //
                      body: CapaDoLivro(index: widget.index),
                    );
                  },
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

  AppBar contruirAppBarLivroDetalhado(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/voltar.svg"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}

// ignore: must_be_immutable
class LivroDetalhado extends StatefulWidget {
  LivroDetalhado({Key? key, required this.index}) : super(key: key);

  int index;

  @override
  State<LivroDetalhado> createState() => _LivroDetalhadoState();
}
