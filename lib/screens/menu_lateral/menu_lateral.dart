import 'dart:convert';

import 'package:camarate_school_library/Screens/menu_lateral/components/centro_de_ajuda/centro_de_ajuda.dart';
import 'package:camarate_school_library/Screens/menu_lateral/components/corpo_docente/corpo_docente.dart';
import 'package:camarate_school_library/Screens/menu_lateral/components/estabelecimento/estabelecimento.dart';
import 'package:camarate_school_library/Screens/menu_lateral/components/procedimentos/procedimentos.dart';
import 'package:camarate_school_library/Screens/menu_lateral/components/sobre/sobre.dart';
import 'package:camarate_school_library/models/pessoa.dart';
import 'package:camarate_school_library/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/auth_services.dart';
import 'components/historico/historico_de_requisicao.dart';
import '../login.dart';

//? Controlador para abertura do menu
ZoomDrawerController _controlarMenuLateral = ZoomDrawerController();

class _MenuLateralState extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    //
    //? Sombras a volta para a ecrã home quando o menu abrir
    List<BoxShadow> sombras = [
      const BoxShadow(
        color: Colors.black45,
        blurRadius: 50,
        offset: Offset(5, 5),
      )
    ];

    //? Menu Lateral
    return ZoomDrawer(
      // seta do android para fechar o menu
      androidCloseOnBackTap: true,

      // mover campos do menu para esquerda quando fechar
      moveMenuScreen: true,

      // tamanho ecrã home quando o menu abre
      mainScreenScale: 0.28,

      // cor total dentro do menu
      menuBackgroundColor: const Color(0xff4285f4),

      controller: _controlarMenuLateral,

      // Bordas arredondadas ecrã home quando menu abre
      borderRadius: 25.0,

      style: DrawerStyle.defaultStyle,

      boxShadow: sombras,

      drawerShadowsBackgroundColor: Colors.grey.shade300,

      // espaçamento entro os campos do menu e o ecrã home
      slideWidth: 255,

      // duração abrir e fechar
      duration: const Duration(milliseconds: 200),

      // rotação do angulo do menu
      angle: 0.0,

      // efeito cor azul ao fechar e abrir
      menuScreenOverlayColor: const Color.fromRGBO(27, 68, 166, 1),

      // Fechar o menu lateral
      mainScreenTapClose: true,

      mainScreen: const Home(),

      menuScreen: const CamposMenuLateral(),
    );
  }
}

class _CamposMenuLateralState extends State<CamposMenuLateral> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff4285f4),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30.0,
          top: 22.0 * 2,
          bottom: 15.0 * 3,
        ),
        child: Container(
          width: size.width * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              //* Dados utilizador
              perfilUtilizador(),

              SizedBox(
                // Espaçamento entre os campos do menu lateral
                height: size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //
                    //? Histórico
                    InkWell(
                      child:
                          campoDoMenu(FluentIcons.book_24_regular, 'Histórico'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            //* Redireciona o utilizador para a página do Histórico
                            builder: (context) => const HistoricoDeRequisicao(),
                          ),
                        );
                      },
                    ),

                    //? Centro de ajuda
                    InkWell(
                      child: campoDoMenu(
                          FluentIcons.chat_help_24_regular, 'Centro de ajuda'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            //* Redireciona o utilizador para a página de Ajuda
                            builder: (context) => const CentroDeAjuda(),
                          ),
                        );
                      },
                    ),

                    //? Sobre nós
                    InkWell(
                      child: campoDoMenu(
                          FluentIcons.mobile_optimized_24_regular, 'Sobre'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            //* Redireciona o utilizador para a página Sobre
                            builder: (context) => const Sobre(),
                          ),
                        );
                      },
                    ),

                    //? Corpo Docente
                    InkWell(
                      child: campoDoMenu(FluentIcons.book_contacts_24_regular,
                          'Corpo Docente'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            //* Redireciona o utilizador para a página Corpo Docente
                            builder: (context) => const CorpoDocente(),
                          ),
                        );
                      },
                    ),

                    //? Procedimentos
                    InkWell(
                      child: campoDoMenu(
                        FluentIcons.clipboard_bullet_list_rtl_20_regular,
                        'Procedimentos',
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            //* Redireciona o utilizador para a página Procedimentos
                            builder: (context) => const Procedimentos(),
                          ),
                        );
                      },
                    ),

                    //? Morada
                    InkWell(
                      child: campoDoMenu(FluentIcons.building_home_24_regular,
                          'Estabelecimento'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            //* Redireciona o utilizador para a página Estabelecimento
                            builder: (context) => const Estabelecimento(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              //const Divider(color: Colors.white),
              const SizedBox(width: 10),

              //? Terminar sessão
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: campoDoMenu(
                        FluentIcons.sign_out_24_regular, 'Logout  |'),
                    onTap: () async {
                      setState(() {});
                      await context.read<AuthServices>().terminarSessao();
                      await Navigator.pushAndRemoveUntil(
                        (context),
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () => launchUrl(
                      Uri.parse('https://portalesc.wixsite.com/site'),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/logotipo/logo_entidade.png',
                          width: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'ESC',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Carmen',
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  perfilUtilizador() {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white38,
          child: const CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white38,
            child: Icon(
              Icons.person,
            ),
          ),
        ),
        const SizedBox(width: 8),
        StreamBuilder(
          stream: FirebaseDatabase.instance.ref("utilizadores").onValue,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              //? Caso não esteja conectado, mostra mensagem
              case ConnectionState.none:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[Text("Sem dados para mostrar...")],
                );

              default:
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data.snapshot.value != null) {
                  //? Alcançar a instância da base de dados para autenticação do utilizador atual
                  final _auth = FirebaseAuth.instance;

                  // Utilizador atual
                  User? utilizador = _auth.currentUser;

                  /// Guardo os dados da base de dados [snapshot.data.snapshot.value]
                  /// numa coleção de pares chave/valor
                  Map<String, dynamic> dadosBaseDeDados =
                      jsonDecode(jsonEncode(snapshot.data.snapshot.value));

                  List<Pessoa> _utilizadoresBD = [];

                  /// Com o forEach separo a chave e o valor para depois escolher o quero
                  /// guardar na lista [_obrasBD], nesse caso é o valor que depois...
                  dadosBaseDeDados.forEach(
                    (chave, valor) {
                      /// atribuo esses dados no fromJson da classe modelo do historico
                      Pessoa user = Pessoa.fromJson(valor);
                      // guardar apenas os valores que vou apresentar na lista
                      _utilizadoresBD.add(user);
                    },
                  );

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 3),
                      for (int i = 0; i < _utilizadoresBD.length; i++)
                        if (_utilizadoresBD[i].uidPessoa ==
                            utilizador?.uid) ...[
                          Text(
                            _utilizadoresBD[i].nomeCompletoPessoa.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _utilizadoresBD[i].numCartaoPessoa.toString(),
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.grey.shade200,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          )
                        ],
                    ],
                  );
                }
            }
            return const Text('sem dados');
          },
        )
      ],
    );
  }

  campoDoMenu(IconData icon, String titulo) {
    return Row(
      children: [
        //
        if (icon == Icons.logout) ...[
          const Icon(
            Icons.logout,
            color: Colors.white,
            size: 20,
          ),
        ] else ...[
          Icon(
            icon,
            color: Colors.white,
          ),
        ],

        //
        const SizedBox(width: 10),

        //
        if (titulo == 'Logout  |') ...[
          Text(
            titulo,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Gilroy',
              fontSize: 17,
            ),
          ),
        ] else ...[
          Text(
            titulo,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ],
    );
  }
}

class MenuLateral extends StatefulWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}

class CamposMenuLateral extends StatefulWidget {
  const CamposMenuLateral({Key? key}) : super(key: key);

  @override
  State<CamposMenuLateral> createState() => _CamposMenuLateralState();
}
