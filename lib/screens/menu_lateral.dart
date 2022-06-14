import 'package:camarate_school_library/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../services/auth_services.dart';
import 'historico_de_requisicao.dart';
import 'login.dart';

final ZoomDrawerController _controlarZoomMenuLateral = ZoomDrawerController();

class _MenuLateralState extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    //
    return ZoomDrawer(
      menuBackgroundColor: Colors.blue,
      controller: _controlarZoomMenuLateral,
      borderRadius: 10.0,
      style: DrawerStyle.defaultStyle,
      showShadow: false,
      openCurve: Curves.fastOutSlowIn,
      slideWidth: MediaQuery.of(context).size.width * 0.55,
      duration: const Duration(milliseconds: 500),
      angle: 0.0,
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
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30.0,
          top: 30.0 * 2,
          bottom: 30.0 * 3,
        ),
        child: SizedBox(
          width: size.width * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 100),

                    // Home
                    Row(
                      children: const [
                        Icon(Icons.home_rounded, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Home',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),

                    // Histórico
                    InkWell(
                        child: Row(
                          children: const [
                            Icon(Icons.book, color: Colors.white),
                            SizedBox(width: 10),
                            Text('Histórico',
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              //** Redireciona o utilizador para a página de detalhes do livro */
                              builder: (context) =>
                                  const HistoricoDeRequisicao(),
                            ),
                          );
                        }),

                    // Ajuda
                    Row(
                      children: const [
                        Icon(Icons.help, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Ajuda', style: TextStyle(color: Colors.white))
                      ],
                    ),

                    // Sobre nós
                    Row(
                      children: const [
                        Icon(Icons.receipt_long_rounded, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Sobre nós', style: TextStyle(color: Colors.white))
                      ],
                    ),

                    const Divider(color: Colors.white),

                    // Terminar sessão
                    InkWell(
                        child: Row(
                          children: const [
                            Icon(Icons.logout, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'Terminar sessão',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        onTap: () async {
                          setState(() {});
                          await context.read<AuthServices>().terminarSessao();
                          await Navigator.pushAndRemoveUntil(
                            (context),
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false,
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
