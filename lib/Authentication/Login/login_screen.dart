import 'dart:convert';

import 'package:camarate_school_library/Authentication/Registo/models/modelo_registo.dart';
import 'package:camarate_school_library/Authentication/Registo/registo.dart';
import 'package:camarate_school_library/Home/layout/layout_pagina_utilizador.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesKeys {
  static const ativarUtilizador = "INFORMACAO_UTILIZADOR_LOGIN";
}

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({Key? key}) : super(key: key);

  @override
  _PaginaLoginState createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  bool esconderPassword = true;
  bool isProcessData = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        margin: const EdgeInsets.only(top: 45),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logotipo
              Image.asset(
                'assets/images/logotipos/logotipo.png',
                height: 139.0,
                alignment: Alignment.centerLeft,
              ),
              // Espaçamento
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Bem Vindo",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Gobold',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Inicia sessão para continuar",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    // --> Campo do E-mail <--
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 5) {
                          return "E-mail muito curto...";
                        } else if (!value.contains("@")) {
                          return "Siga o exemplo --> exemplo@gmail.com | exemplo@hotmail.com";
                        } else if (value.isEmpty) {
                          return "O nome de utilizador que inseriste não pertence a nenhuma conta. Verifica o teu nome de utilizador e tenta novamente.";
                        }
                        return null;
                      },
                      controller: emailInputController,
                      autofocus: true,
                      // Estilo dentro do campo de e-mail
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 2.0,
                      ),
                      decoration: const InputDecoration(
                        labelText: "E-mail ou número do cartão de aluno",
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
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // --> Campo da Palavra-passe <---
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 8) {
                          return "A palavra-passe deve conter pelo menos 8 caracteres";
                        } else if (value == null || value.isEmpty) {
                          return "Desculpa, mas a tua palavra-passe está incorreta. Verifica-a novamente.";
                        }
                        return null;
                      },
                      obscureText: esconderPassword,
                      controller: passwordInputController,
                      // Estilo dentro do campo da palavra-passe
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 2.0,
                      ),
                      decoration: InputDecoration(
                        labelText: "Palavra-passe",
                        labelStyle: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(127, 127, 127, 2),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              esconderPassword = !esconderPassword;
                            });
                          },
                          child: Icon(
                            esconderPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Color.fromRGBO(204, 204, 204, 2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 15),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Esqueceste-te da palavra-passe?",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(28, 142, 221, 2),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 50),
              ),

              // --> botao [Iniciar Sessão] <--
              SizedBox(
                height: 65.0,
                width: 335.0,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isProcessData = true;
                      });

                      Future.delayed(
                        const Duration(seconds: 3),
                        () {
                          setState(
                            () {
                              isProcessData = false;
                            },
                          );
                          fazerLogin();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const LayoutPaginaPrincipalUtilizador()));
                        },
                      );
                    } else {
                      // ignore: avoid_print
                      print("invalido");
                    }
                  },
                  child: isProcessData
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 10,
                            ),
                            CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ],
                        )
                      : const Text(
                          "Iniciar sessão",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 35),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Não tens uma conta? ",
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Registo(),
                            ),
                          );
                        },
                      text: ' Regista-te.',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fazerLogin() async {
    String emailDoUtilizador = emailInputController.text;
    String passwordDoUtilizador = passwordInputController.text;

    ModeloRegistoUtilizador dadosUtilizadorInseridos =
        await getDadosGuardadosDoUtilizador();

    if (emailDoUtilizador == dadosUtilizadorInseridos.email &&
        passwordDoUtilizador == dadosUtilizadorInseridos.password) {
      // ignore: avoid_print
      print('Login efetuado com sucesso');
    } else {
      // ignore: avoid_print
      print('Falha ao tentar iniciar sessão');
    }
  }

  Future<ModeloRegistoUtilizador> getDadosGuardadosDoUtilizador() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUtilizador = prefs.getString(PreferencesKeys.ativarUtilizador);
    // ignore: avoid_print
    print(jsonUtilizador);

    Map<String, dynamic> mapUtilizador = json.decode(jsonUtilizador!);
    ModeloRegistoUtilizador utilizador =
        ModeloRegistoUtilizador.fromJson(mapUtilizador);
    return utilizador;
  }
}
