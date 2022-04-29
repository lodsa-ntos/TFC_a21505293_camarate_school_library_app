import 'package:flutter/material.dart';

//?___________________________________ESTILO LOGIN________________________________________________

abstract class StyleLoginScreen {
  //?____________________________TÍTULOS DE AUTENTICACAO___________________________________

  /// Estilo do titulo LOGIN
  static const TextStyle estiloTituloLogin = TextStyle(
    fontFamily: 'Gobold',
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  //?____________________________E-MAIL_________________________________________

  /// Estilo dentro do campo de e-mail
  static const TextStyle estiloCampoDoEmail = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 2.0,
  );

  /// Estilo da decoração do campo do e-mail
  static const InputDecoration decoracaoCampoDoEmail = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    filled: true,
    labelText: "Nome de utilizador ou número de cartão",
    labelStyle: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(127, 127, 127, 2),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: Color.fromRGBO(204, 204, 204, 2),
      ),
    ),
  );

  //?____________________________PASSWORD_______________________________________

  /// Estilo dentro do campo da palavra-passe
  static const TextStyle estiloCampoDaPassword = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 2.0,
  );

  //?____________________________ESTILO BOTÃO LOGIN_____________________________

  /// Estilo do titulo LOGIN
  static const TextStyle estiloBotaoIniciarSessao = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

//*___________________________________ESTILO REGISTO________________________________________________

abstract class StyleRegistoScreen {
  //*____________________________TÍTULOS DE AUTENTICACAO___________________________________

  /// Estilo do titulo LOGIN
  static const TextStyle estiloTituloRegisto = TextStyle(
    fontFamily: 'Gobold',
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  //*____________________________Número de Cartao_________________________________________

  /// Estilo dentro do campo de e-mail
  static const TextStyle estiloNumCartao = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 2.0,
  );

  /// Estilo da decoração do campo do e-mail
  static const InputDecoration decoracaoNumCartao = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    filled: true,
    labelText: "Número de cartão",
    labelStyle: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(127, 127, 127, 2),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: Color.fromRGBO(204, 204, 204, 2),
      ),
    ),
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
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    filled: true,
    labelText: "E-mail",
    labelStyle: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(127, 127, 127, 2),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: Color.fromRGBO(204, 204, 204, 2),
      ),
    ),
  );

  //*____________________________Nome Completo_________________________________________

  /// Estilo dentro do campo de e-mail
  static const TextStyle estiloNomeCompleto = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 2.0,
  );

  /// Estilo da decoração do campo do e-mail
  static const InputDecoration decoracaoNomeCompleto = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    filled: true,
    labelText: "Nome completo",
    labelStyle: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(127, 127, 127, 2),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: Color.fromRGBO(204, 204, 204, 2),
      ),
    ),
  );

  //*____________________________Nome de utilizador_________________________________________

  /// Estilo dentro do campo de e-mail
  static const TextStyle estiloNomeUtilizador = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 2.0,
  );

  /// Estilo da decoração do campo do e-mail
  static const InputDecoration decoracaoNomeUtilizador = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    filled: true,
    labelText: "Nome de utilizador",
    labelStyle: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      fontWeight: FontWeight.w600,
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
