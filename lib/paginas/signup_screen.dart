import 'package:camarate_school_library/paginas/authLogin/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        margin: const EdgeInsets.only(top: 45),
        color: Colors.white,
        // assets/icons/logotipo.png
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Regista-te",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'Gobold',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(51, 51, 51, 1)),
              ),
              const SizedBox(
                height: 13,
              ),
              const Text(
                "E embarca nas viagens da leitura na tua biblioteca",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 33,
              ),
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
              const SizedBox(
                height: 10,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    // --> Primeiro nome <--
                    TextFormField(
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

                    // --> Último nome <--
                    TextFormField(
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

                    // --> E-mail ou número do cartão de aluno <--
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
                        height: 2.0,
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

                    // --> Palavra-passe <--
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 8) {
                          return "A palavra-passe deve conter pelo menos 8 caracteres";
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
                          fontSize: 14,
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
                            showPassword
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

              const SizedBox(
                height: 31,
              ),
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

              const SizedBox(
                height: 20,
              ),

              // --> Número de aluno <--
              TextFormField(
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

                // Apenas inserir números
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              // --> Ano/Turma <--
              TextFormField(
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

                // Apenas inserir números
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              // --> Diretor/a de Turma <--
              TextFormField(
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
                height: 31,
              ),
              const Text(
                "Informações adicionais",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(28, 142, 221, 2),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              // --> Sobre o utilizador <--
              TextFormField(
                controller: aboutUserInputController,
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                maxLength: 500,
                decoration: const InputDecoration(
                  labelText: 'Sobre mim',
                  labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
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
              ),

              const SizedBox(
                height: 30,
              ),

              // --> Botão CRIAR CONTA <--
              SizedBox(
                height: 65.0,
                width: 335.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return HomeScreen();
                      }),
                    );
                  },
                  child: const Text(
                    "Criar Conta",
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
                padding: EdgeInsets.only(bottom: 15),
              ),

              // --> Navegar para a página de LOGIN <--
              const Text(
                "Já tens uma conta? ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Inicia sessão.",
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
}
