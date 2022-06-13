import 'package:camarate_school_library/screens/home.dart';
import 'package:camarate_school_library/screens/pesquisar.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class _MenuLateralState extends State<MenuLateral> {
  //? Lista para os campos do menu lateral
  List<ScreenHiddenDrawer> _screens = [];

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
      )
    ];
    super.initState();
  }

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

      //? Icon pesquisar
      actionsAppBar: <Widget>[
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                //? Redireciona o utilizador para a página de detalhes do livro
                builder: (context) => const PesquisaDeLivro(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class MenuLateral extends StatefulWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}
