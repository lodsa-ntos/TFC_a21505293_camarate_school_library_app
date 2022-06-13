import 'package:camarate_school_library/screens/home.dart';
import 'package:camarate_school_library/screens/pesquisar.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import 'historico_de_requisicao.dart';

class _MenuLateralState extends State<MenuLateral> {
  //? Lista para os campos do menu lateral
  List<ScreenHiddenDrawer> _screens = [];

  @override
  Widget build(BuildContext context) {
    //
    return HiddenDrawerMenu(
      // Cor para dentro do menu lateral
      backgroundColorMenu: Colors.blue,

      // Lista dos campos do menu lateral
      screens: _screens,

      // Posicionar a página inicial selecionado no menu (iniciar em 0)
      initPositionSelected: 0,

      // Titulo Home no centro
      isTitleCentered: true,

      tittleAppBar: const Text('Camarate School Library'),

      //? Icon pesquisar
      actionsAppBar: <Widget>[
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                //? Redireciona o utilizador para a página para pesquisar um livro
                builder: (context) => const PesquisaDeLivro(),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    //* iniciar a lista com os campos para o menu lateral
    _screens = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Home',
          baseStyle: const TextStyle(),
          selectedStyle: const TextStyle(),
          colorLineSelected: Colors.green,
        ),
        const Home(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Histórico',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              //? Redireciona o utilizador para a página Historico de requisicao
              builder: (context) => const HistoricoDeRequisicao(),
            ),
          ),
          baseStyle: const TextStyle(),
          selectedStyle: const TextStyle(),
          colorLineSelected: Colors.green,
        ),
        const HistoricoDeRequisicao(),
      )
    ];
    super.initState();
  }
}

class MenuLateral extends StatefulWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}
