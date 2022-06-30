import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//?___________________________________ESTILO LOGIN________________________________________________

abstract class StyleLoginScreen {
  //?____________________________TÍTULOS DE AUTENTICACAO___________________________________

  /// Estilo do titulo LOGIN
  static TextStyle estiloTituloBibliotecaEscolar = GoogleFonts.concertOne(
    fontSize: 25,
    fontWeight: FontWeight.w500,
  );

  /// Estilo do titulo LOGIN
  static TextStyle estiloSubTituloCamarate = GoogleFonts.concertOne(
    fontSize: 25,
    fontWeight: FontWeight.w500,
  );

  //?____________________________E-MAIL_________________________________________

  /// Estilo dentro do campo de e-mail
  static const TextStyle estiloCampoDoEmail = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  /// Estilo da decoração do campo do e-mail
  static InputDecoration decoracaoCampoDoEmail = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    labelText: "E-mail",
    labelStyle: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(127, 127, 127, 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: Color.fromARGB(255, 171, 211, 250).withOpacity(0.4),
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    filled: true,
    //filled: true,
  );

  //?____________________________PASSWORD_______________________________________

  /// Estilo dentro do campo da palavra-passe
  static const TextStyle estiloCampoDaPassword = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  //?____________________________ESTILO BOTÃO LOGIN_____________________________

  /// Estilo do titulo LOGIN
  static const TextStyle estiloBotaoIniciarSessao = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

//*___________________________________ESTILO REGISTO________________________________________________

abstract class StyleRegistoScreen {
  //*____________________________TÍTULOS DE AUTENTICACAO___________________________________

  /// Estilo do titulo LOGIN
  static TextStyle estiloTituloRegisto = GoogleFonts.concertOne(
    fontSize: 25,
    fontWeight: FontWeight.w500,
  );

  //*____________________________NÚMERO DE CARTÃO_________________________________________

  /// Estilo dentro do campo de e-mail
  static const TextStyle estiloNumCartao = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  /// Estilo da decoração do campo do e-mail
  static InputDecoration decoracaoNumCartao = InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    labelStyle: GoogleFonts.roboto(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(127, 127, 127, 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  );

  //*____________________________E-MAIL_________________________________________

  /// Estilo dentro do campo de e-mail
  static const TextStyle estiloCampoDoEmail = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  /// Estilo da decoração do campo do e-mail
  static InputDecoration decoracaoCampoDoEmail = InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    labelStyle: GoogleFonts.roboto(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(127, 127, 127, 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  );

  //*____________________________NOME COMPLETO_________________________________________

  /// Estilo dentro do campo de e-mail
  static const TextStyle estiloNomeCompleto = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  /// Estilo da decoração do campo do e-mail
  static InputDecoration decoracaoNomeCompleto = InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    labelStyle: GoogleFonts.roboto(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(127, 127, 127, 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  );

  //*____________________________NOME DE UTILIZADOR_________________________________________

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

  //*____________________________NÚMERO ALUNO_________________________________________

  /// Estilo dentro do campo de e-mail
  static const TextStyle estiloNumeroAluno = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 2.0,
  );

  /// Estilo da decoração do campo do e-mail
  static const InputDecoration decoracaoNumeroAluno = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    filled: true,
    labelText: "Nº",
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

  //*____________________________ANO_________________________________________

  /// Estilo dentro do campo de e-mail
  static const TextStyle estiloAno = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 2.0,
  );

  /// Estilo da decoração do campo do e-mail
  static const InputDecoration decoracaoAno = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    filled: true,
    labelText: "Ano",
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

  //*____________________________TURMA_________________________________________

  /// Estilo dentro do campo de e-mail
  static const TextStyle estiloTurma = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 2.0,
  );

  /// Estilo da decoração do campo do e-mail
  static const InputDecoration decoracaoTurma = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    filled: true,
    labelText: "Ano/Turma",
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
}
