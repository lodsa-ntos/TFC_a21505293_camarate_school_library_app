import 'package:camarate_school_library/Authentication/Registo/registo.dart';
import 'package:camarate_school_library/Home/layout/layout_pagina_utilizador.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  // Autenticação com o firebase
  final _auth = FirebaseAuth.instance;

  // string para mostrar a mensagem de erro
  String? mensagemDeErro;

  @override
  Widget build(BuildContext context) {
    // ---> Campo do E-mail <---
    final campoEmail = TextFormField(
      autofocus: false,
      controller: emailInputController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          // ignore: prefer_adjacent_string_concatenation
          return "O nome de utilizador que inseriste não pertence a nenhuma conta. \n\nVerifica o teu nome de utilizador e tenta novamente.";
        }

        if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return "Siga o exemplo: \n exemplo@gmail.com | exemplo@hotmail.com";
        }

        if (value.length < 5) {
          return "E-mail muito curto...";
        }
        return null;
      },
      onSaved: (value) {
        emailInputController.text = value!;
      },
      textInputAction: TextInputAction.next,
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

    // ---> Campo da Palavra-passe <---
    final campoPalavraPasse = TextFormField(
      autofocus: false,
      obscureText: esconderPassword,
      controller: passwordInputController,
      validator: (value) {
        // ignore: unnecessary_new
        RegExp regex = new RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

        if (value!.isEmpty) {
          return "Desculpe, mas a sua palavra-passe está incorreta. \nVerifica-a novamente.";
        }

        if (!regex.hasMatch(value)) {
          return "Tens de introduzir uma palavra-passe válida. \nA palavra-passe deve conter pelo menos 8 caracteres";
        }
      },
      onSaved: (value) {
        passwordInputController.text = value!;
      },
      textInputAction: TextInputAction.done,
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
            esconderPassword ? Icons.visibility_off : Icons.visibility,
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

    // ---> Esqueceste-te da palavra-passe? <---
    final forgotPalavraPasse = GestureDetector(
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
    );

    // ---> botao [Iniciar Sessão] <---
    final botaoIniciarSessao = SizedBox(
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
                fazerLogin(
                    emailInputController.text, passwordInputController.text);
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
    );

    // ---> Não tens uma conta? Regista-te. <---
    final naoTensUmaContaRegistate = RichText(
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
    );

    // ---> Logotipo <---
    final logotipo = Image.asset(
      'assets/images/logotipos/logotipo.png',
      height: 139.0,
      alignment: Alignment.centerLeft,
    );

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
              logotipo,

              // Espaçamento
              const SizedBox(height: 15),

              const Text(
                "Bem Vindo",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Gobold',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "Inicia sessão para continuar",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 45),

              // --> Formulário Login <--
              Form(
                key: formKey,
                child: Column(
                  children: [
                    // --> Campo do E-mail <--
                    campoEmail,

                    const SizedBox(height: 20),

                    // ---> Campo da Palavra-passe <---
                    campoPalavraPasse,
                  ],
                ),
              ),

              const Padding(padding: EdgeInsets.only(bottom: 15)),

              // ---> Esqueceste-te da palavra-passe? <---
              forgotPalavraPasse,

              const Padding(padding: EdgeInsets.only(bottom: 50)),

              // ---> botao [Iniciar Sessão] <---
              botaoIniciarSessao,

              const Padding(padding: EdgeInsets.only(bottom: 35)),

              // ---> Não tens uma conta? Regista-te. <---
              naoTensUmaContaRegistate,
            ],
          ),
        ),
      ),
    );
  }

  // incompleto
  void fazerLogin(String email, String password) async {
    if (formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login efetuado com sucesso"),
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        const LayoutPaginaPrincipalUtilizador(),
                  ),
                ),
              });
    }
  }
}
