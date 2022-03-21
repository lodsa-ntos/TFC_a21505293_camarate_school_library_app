import 'package:camarate_school_library/Screens/home.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  bool esconderPassword = true;
  bool isDadosCorretos = false;
  final chaveDeFormulario = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Variável
    final _textoDaPassword = InputDecoration(
      labelText: "Palavra-passe",
      labelStyle: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(127, 127, 127, 2),
      ),
      suffixIcon: InkWell(
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
              const Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Gobold',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 45),

              Form(
                key: chaveDeFormulario,
                child: Column(
                  children: [
                    //* --> Campo do E-mail <--
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

                      //* Obter o valor do email escrito pelo user
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
                        labelText: "E-mail",
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

                    const SizedBox(height: 20),

                    //* --> Campo da Palavra-passe <---
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 8) {
                          return "A palavra-passe deve conter pelo menos 8 caracteres";
                        } else if (value.isEmpty) {
                          return "Desculpa, mas a tua palavra-passe está incorreta. Verifica-a novamente.";
                        }
                        return null;
                      },

                      //* Esconder a palavra-passe
                      obscureText: esconderPassword,
                      //* Obter o valor da password escrito pelo user
                      controller: passwordInputController,
                      // Estilo dentro do campo da palavra-passe
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 2.0,
                      ),
                      decoration: _textoDaPassword,
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 50)),

              //* --> Botão [Iniciar Sessão] <--
              SizedBox(
                height: 65.0,
                width: 335.0,
                child: ElevatedButton(
                  onPressed: () {
                    if (chaveDeFormulario.currentState!.validate()) {
                      setState(() {
                        isDadosCorretos = true;
                      });

                      Future.delayed(
                        const Duration(seconds: 3),
                        () {
                          setState(() {
                            isDadosCorretos = false;
                          });

                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const Home()));
                        },
                      );
                    } else {
                      // ignore: avoid_print
                      print("invalido");
                    }
                  },

                  //* Ao clicar, se os dados estiverem corretos simula um CircularProgress
                  child: isDadosCorretos
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
            ],
          ),
        ),
      ),
    );
  }
}
