import 'dart:convert';

import 'package:camarate_school_library/Authentication/Login/login_screen.dart';
import 'package:camarate_school_library/Authentication/Models/modelo_utilizador.dart';
import 'package:camarate_school_library/Home/layout/layout_pagina_utilizador.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  TextEditingController confirmarPasswordInputController =
      TextEditingController();
  TextEditingController yearAndClassStudentInputController =
      TextEditingController();

  bool mostrarPalavraPasse = true;
  bool mostrarPalavraPasseDaConfirmacao = true;
  bool isProcessData = false;

  final formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //
    // --> Primeiro nome <--
    final primeiroNome = TextFormField(
      controller: nameInputController,
      keyboardType: TextInputType.name,
      autofocus: false,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("O nome não pode ser vazio");
        }
        if (!regex.hasMatch(value)) {
          return ("Introduza um nome válido (Min. 3 caracteres)");
        }
        return null;
      },
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
      controller: lastNameInputController,
      keyboardType: TextInputType.name,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return ("O seu apelido não pode ser vazio");
        }
        return null;
      },
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
      controller: emailInputController,
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          // ignore: prefer_adjacent_string_concatenation
          return "O nome de utilizador que inseriste não pertence a nenhuma \nconta. \nVerifica o teu nome de utilizador e tenta novamente.";
        }

        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return "Siga os exemplos: \nexemplo@gmail.com | exemplo@hotmail.com";
        }

        if (value.length < 5) {
          return "E-mail muito curto...";
        }
        return null;
      },
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
      obscureText: mostrarPalavraPasse,
      controller: passwordInputController,
      validator: (value) {
        // ignore: unnecessary_new
        RegExp regex = new RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

        if (value!.isEmpty) {
          return "A palavra-passe é necessária para fazeres login";
        }

        if (regex.hasMatch(value)) {
          return "Tens de introduzir uma palavra-passe válida. \nA palavra-passe deve conter pelo menos 8 caracteres";
        }
      },
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
              mostrarPalavraPasse = !mostrarPalavraPasse;
            });
          },
          child: Icon(
            mostrarPalavraPasse ? Icons.visibility_off : Icons.visibility,
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

    // --> Confirmar a palavra-passe <--
    final confirmarPasswordDoRegisto = TextFormField(
      obscureText: mostrarPalavraPasseDaConfirmacao,
      controller: confirmarPasswordInputController,
      validator: (value) {
        if (confirmarPasswordInputController.text !=
            passwordInputController.text) {
          return "A palavra-passe não corresponde";
        }
        return null;
      },
      onSaved: (value) {
        confirmarPasswordInputController.text = value!;
      },
      // Estilo dentro do campo da palavra-passe
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 2.0,
      ),
      decoration: InputDecoration(
        labelText: "Confirmar palavra-passe",
        labelStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(127, 127, 127, 2),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              mostrarPalavraPasseDaConfirmacao =
                  !mostrarPalavraPasseDaConfirmacao;
            });
          },
          child: Icon(
            mostrarPalavraPasseDaConfirmacao
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
    );

    // --> Número de aluno <--
    final numeroAluno = TextFormField(
      controller: studentNumberInputController,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return "O seu número de aluno não pode ser vazio";
        }
      },
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
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return "O seu ano e a sua turma não podem ser vazios";
        }
      },
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
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return "O nome do seu/sua Diretor/a de turma não pode ser vazio";
        }
      },
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
      autofocus: false,
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
                registarUtilizador(
                  emailInputController.text,
                  passwordInputController.text,
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            const LayoutPaginaPrincipalUtilizador()));
              },
            );
          } else {
            // ignore: avoid_print
            print("Utilizador inválido");
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
                "Criar Conta",
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
                    passwordDoRegisto,

                    const SizedBox(height: 20),

                    // --> Confirmar palavra-passe <--
                    confirmarPasswordDoRegisto,
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

  void registarUtilizador(String email, String password) async {
    if (formKey.currentState!.validate()) {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFirestore(),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    // chamar a base de dados firestore
    // chamar o modelo de utilizador
    // guardar os valores introduzidos pelo utilizador

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? utilizador = auth.currentUser;

    ModeloUtilizador modeloRegistoUtilizador = ModeloUtilizador();

    // registar todos os valores
    modeloRegistoUtilizador.uid = utilizador!.uid;
    modeloRegistoUtilizador.nomeProprio = nameInputController.text;
    modeloRegistoUtilizador.ultimoNome = lastNameInputController.text;
    modeloRegistoUtilizador.email = utilizador.email;

    await firebaseFirestore
        .collection("Utilizadores")
        .doc(utilizador.uid)
        .set(modeloRegistoUtilizador.toMap());
    Fluttertoast.showToast(msg: "Conta criada com sucesso :)");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(
          builder: (context) => const LayoutPaginaPrincipalUtilizador(),
        ),
        (route) => false);
  }
}
