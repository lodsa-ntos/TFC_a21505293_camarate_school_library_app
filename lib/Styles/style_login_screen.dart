import 'package:flutter/material.dart';

abstract class StyleLoginScreen {
  //*____________________________TITULO LOGIN___________________________________

  /// Estilo do titulo LOGIN
  static const TextStyle estiloTituloLogin = TextStyle(
    fontFamily: 'Gobold',
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  //*____________________________E-MAIL_________________________________________

  /// Estilo dentro do campo de e-mail
  static const TextStyle estiloCampoDoEmail = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 2.0,
  );

  /// Estilo da decoração do campo do e-mail
  static const InputDecoration decoracaoCampoDoEmail = InputDecoration(
    labelText: "E-mail ou nome de utilizador",
    labelStyle: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: Color.fromRGBO(127, 127, 127, 2),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: Color.fromRGBO(204, 204, 204, 2),
      ),
    ),
  );

  //*____________________________PASSWORD_______________________________________

  /// Estilo dentro do campo da palavra-passe
  static const TextStyle estiloCampoDaPassword = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 2.0,
  );

  //*____________________________ESTILO BOTÃO LOGIN_____________________________

  /// Estilo do titulo LOGIN
  static const TextStyle estiloBotaoIniciarSessao = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
