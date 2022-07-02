import 'package:camarate_school_library/Screens/home/home.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';
import 'package:camarate_school_library/screens/detalhes_do_livro/components/capa_do_livro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LivroDetalhado extends StatelessWidget {
  LivroDetalhado({Key? key, required this.index}) : super(key: key);

  int index;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer<LivroRequisitadoModel>(
        builder: (context, requisitadoModel, child) {
      return Scaffold(
        //
        appBar: contruirAppBarLivroDetalhado(context),

        //
        body: CapaDoLivro(index: index),
      );
    });
  }

  AppBar contruirAppBarLivroDetalhado(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/voltar.svg"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              //** Redireciona o utilizador para a página home
              builder: (context) => const Home(),
            ),
          );
        },
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
