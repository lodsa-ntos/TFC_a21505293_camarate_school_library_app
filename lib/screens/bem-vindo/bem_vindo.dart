import 'package:camarate_school_library/screens/login.dart';
import 'package:camarate_school_library/screens/registar.dart';
import 'package:camarate_school_library/util/navegador.dart';
import 'package:flutter/material.dart';

class BemVindo extends StatelessWidget {
  const BemVindo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: 55.0),
                Image.asset(
                  'assets/logotipo/ic_launcher_adaptive_fore.png',
                  filterQuality: FilterQuality.high,
                  width: 90,
                ),
                SizedBox(height: 10.0),
                Text(
                  'Biblioteca Escolar',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4285f4),
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  'Camarate',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Carmen',
                    fontWeight: FontWeight.w900,
                    color: Color(0xff4267B2),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 115.0),
                Text(
                  'Bem-vindo',
                  style: TextStyle(
                    fontSize: 27,
                    fontFamily: 'Carmen',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 45, right: 45, top: 22, bottom: 50),
                  child: Text(
                    'Faça login e embarca nas viajens da leitura na tua biblioteca',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                //? Butões
                ButtonTheme(
                  minWidth: 350.0,
                  child: MaterialButton(
                    height: 50,
                    textColor: Colors.white,
                    color: Color(0xff4285f4),
                    child: Text(
                      "Iniciar sessão",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Carmen',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.1,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        Navegador(widget: LoginScreen()),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                ButtonTheme(
                  minWidth: 350.0,
                  child: MaterialButton(
                    height: 50,
                    textColor: Colors.black,
                    color: Color(0xffDFEFFE),
                    child: Text(
                      "Registar",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Carmen',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        Navegador(widget: Registar()),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
