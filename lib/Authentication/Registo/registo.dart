import 'dart:convert';

import 'package:camarate_school_library/Authentication/Login/login_screen.dart';
import 'package:camarate_school_library/Home/layout/layout_pagina_utilizador.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/modelo_registo.dart';

class PreferencesKeys {
  static const activeUser = "IFORMACAO_UTILIZADOR_LOGIN";
}

class Registo extends StatefulWidget {
  const Registo({Key? key}) : super(key: key);

  @override
  _RegistoState createState() => _RegistoState();
}

class _RegistoState extends State<Registo> {
  // Controladores para guardar informação do formulário
  TextEditingController nameInputController = TextEditingController();
  TextEditingController lastNameInputController = TextEditingController();
  TextEditingController studentNumberInputController = TextEditingController();
  TextEditingController directorNameInputController = TextEditingController();
  TextEditingController aboutUserInputController = TextEditingController();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController yearAndClassStudentInputController =
      TextEditingController();

  bool showPassword = true;
  bool isProcessData = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //
    // --> Primeiro nome <--
    final primeiroNome = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Este nome de utilizador não existe. Tenta outro.";
        }
        return null;
      },
      controller: nameInputController,
      autofocus: true,
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 2.0,
      ),
      decoration: const InputDecoration(
        labelText: "Primeiro nome",
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
    );

    // --> Último nome <--
    final ultimoNome = TextFormField(
      validator: (value) {
        if (value!.isEmpty || value.length > 10) {
          return "Coloque o seu apelido.";
        }
        return null;
      },
      controller: lastNameInputController,
      autofocus: true,
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 2.0,
      ),
      decoration: const InputDecoration(
        labelText: "Último nome",
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
    );

    // --> E-mail ou número do cartão de aluno <--
    final emailDoRegisto = TextFormField(
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
    );

    // --> Palavra-passe <--
    final passwordDoRegisto = TextFormField(
      validator: (value) {
        if (value!.length < 8) {
          return "A palavra-passe deve conter pelo menos 8 caracteres";
        } else if (value.isEmpty) {
          return "Desculpa, mas a tua palavra-passe está incorreta. Verifica-a novamente.";
        }
        return null;
      },
      obscureText: showPassword,
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
              showPassword = !showPassword;
            });
          },
          child: Icon(
            showPassword ? Icons.visibility_off : Icons.visibility,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: Color.fromRGBO(204, 204, 204, 2),
          ),
        ),
      ),
    );

    // --> Número de aluno <--
    final numeroAluno = TextFormField(
      controller: studentNumberInputController,
      autofocus: true,
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 2.0,
      ),
      decoration: const InputDecoration(
        labelText: "Número de aluno",
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

      // Apenas inserir números
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
    );

    // --> Ano/Turma <--
    final anoETurma = TextFormField(
      controller: yearAndClassStudentInputController,
      autofocus: true,
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 2.0,
      ),
      decoration: const InputDecoration(
        labelText: "Ano/Turma",
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

      // Apenas inserir números
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
    );

    // --> Diretor/a de Turma <--
    final diretorTurma = TextFormField(
      controller: directorNameInputController,
      autofocus: true,
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 2.0,
      ),
      decoration: const InputDecoration(
        labelText: "Diretor/a de Turma",
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
    );

    // --> Sobre o utilizador <--
    final textoSobreUtilizador = TextFormField(
      controller: aboutUserInputController,
      keyboardType: TextInputType.multiline,
      maxLines: 8,
      maxLength: 500,
      decoration: const InputDecoration(
        labelText: 'Sobre mim',
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(127, 127, 127, 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color.fromRGBO(0, 0, 0, 2),
          ),
        ),
      ),
    );

    // --> Botão CRIAR CONTA <--
    final botaoCriarConta = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      color: Colors.blue,
      child: MaterialButton(
        height: 65,
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
                registarUtilizador();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            const LayoutPaginaPrincipalUtilizador()));
              },
            );
          } else {
            // ignore: avoid_print
            print("Utilizador invalido");
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
    );

    // --> Navegar para a página de LOGIN <--
    final jaTensUmaConta = RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Já tens uma conta? ",
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
                    builder: (context) => const PaginaLogin(),
                  ),
                );
              },
            text: ' Inicia sessão.',
            style: const TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.blue,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    final tituloInformacoesAdicionais = RichText(
      textAlign: TextAlign.left,
      text: const TextSpan(
        text: "Informações adicionais ",
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(28, 142, 221, 2),
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' (Opcional)',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );

    return Scaffold(
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
              const SizedBox(height: 15),

              const Text(
                "Regista-te",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'Gobold',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(51, 51, 51, 1)),
              ),

              const SizedBox(height: 13),

              const Text(
                "E embarca nas viagens da leitura na tua biblioteca",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 33),

              const Text(
                "Informações pessoais",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(28, 142, 221, 2),
                ),
              ),

              const SizedBox(height: 10),

              Form(
                key: formKey,
                child: Column(
                  children: [
                    //
                    // --> Primeiro nome <--
                    primeiroNome,

                    const SizedBox(height: 20),

                    // --> Último nome <--
                    ultimoNome,

                    const SizedBox(height: 20),

                    // --> E-mail ou número do cartão de aluno <--
                    emailDoRegisto,

                    const SizedBox(height: 20),

                    // --> Palavra-passe <--
                    passwordDoRegisto
                  ],
                ),
              ),

              const SizedBox(height: 31),

              const Text(
                "Informações como requisitante",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(28, 142, 221, 2),
                ),
              ),

              const SizedBox(height: 20),

              // --> Número de aluno <--
              numeroAluno,

              const SizedBox(height: 20),

              // --> Ano/Turma <--
              anoETurma,

              const SizedBox(height: 20),

              // --> Diretor/a de Turma <--
              diretorTurma,

              const SizedBox(height: 31),

              tituloInformacoesAdicionais,

              const SizedBox(height: 30),

              // --> Sobre o utilizador <--
              textoSobreUtilizador,

              const SizedBox(height: 30),

              // --> Botão CRIAR CONTA <--
              botaoCriarConta,

              const Padding(padding: EdgeInsets.only(bottom: 15)),

              // --> Navegar para a página de LOGIN <--
              jaTensUmaConta,
            ],
          ),
        ),
      ),
    );
  }

  // funçao para guardar os dados inseridos pelo utilizador
  void registarUtilizador() {
    ModeloRegistoUtilizador novoUtilizador = ModeloRegistoUtilizador(
      primeiroNome: nameInputController.text,
      ultimoNome: lastNameInputController.text,
      email: emailInputController.text,
      password: passwordInputController.text,
      numeroAluno: studentNumberInputController.text,
      anoTurma: yearAndClassStudentInputController.text,
      diretorTurma: directorNameInputController.text,
      textoSobreUtilizador: aboutUserInputController.text,
    );

    guardarDadosUtilizador(novoUtilizador);
  }

  void guardarDadosUtilizador(ModeloRegistoUtilizador utilizador) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Salvo o texto do utilizador com o setString da função SharedPreferences
    prefs.setString(
      PreferencesKeys.activeUser,
      json.encode(utilizador.toJson()),
    );
  }
}
