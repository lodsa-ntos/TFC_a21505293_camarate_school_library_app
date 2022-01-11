import 'package:camarate_school_library/guia_de_estilo/color_styles.dart';
import 'package:camarate_school_library/paginas/home_screen.dart';
import 'package:camarate_school_library/paginas/signup_screen.dart';
import 'package:flutter/material.dart';

import 'login_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  bool obscurePassword = true;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        margin: const EdgeInsets.only(top: 45),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                height: 66,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    // --> Campo do e-mail <--
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 5) {
                          return "E-mail muito curto";
                        } else if (!value.contains("@")) {
                          return "Siga o exemplo --> @gmail.com";
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
                      ),
                      decoration: const InputDecoration(
                        labelText: "E-mail ou número do cartão de aluno",
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
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
                        }
                        return null;
                      },
                      obscureText: obscurePassword,
                      controller: passwordInputController,
                      // Estilo dentro do campo da palavra-passe
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        labelText: "Palavra-passe",
                        labelStyle: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(127, 127, 127, 2),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          child: Icon(
                            obscurePassword
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
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 45),
              ),
              SizedBox(
                height: 65.0,
                width: 335.0,
                child: ElevatedButton(
                  onPressed: () {
                    doLogin();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  child: const Text(
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
              const Text(
                "Não tens uma conta?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Regista-te.",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void doLogin() async {
    if (formKey.currentState!.validate()) {
      LoginService()
          .login(emailInputController.text, passwordInputController.text);
    } else {
      print("invalido");
    }
  }
}
