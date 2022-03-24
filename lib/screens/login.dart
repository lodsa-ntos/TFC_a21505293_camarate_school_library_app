import 'package:camarate_school_library/Models/Auth/auth_model.dart';
import 'package:camarate_school_library/Styles/style_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Controladores para os campos de texto do e-mail e da password.
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  bool esconderPassword = true;
  bool isDadosCorretos = false;
  final chaveDeFormulario = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Variável
    final _decoracaoCampoDaPassword = InputDecoration(
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
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: chaveDeFormulario,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 100),

                  const Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: StyleLoginScreen.estiloTituloLogin,
                  ),

                  const SizedBox(height: 45),

                  //* E-mail
                  TextFormField(
                    validator: (val) => val!.isNotEmpty
                        ? null
                        : "Por favor, introduza um endereço de e-mail",

                    // Obter o valor do email escrito pelo user
                    controller: emailInputController,

                    // Estilo dentro do campo de e-mail
                    style: StyleLoginScreen.estiloCampoDoEmail,

                    // Estilo da decoração do campo do e-mail
                    decoration: StyleLoginScreen.decoracaoCampoDoEmail,
                  ),

                  const SizedBox(height: 20),

                  //* Palavra-passe
                  TextFormField(
                    validator: (val) => val!.length < 8
                        ? "A palavra-passe deve conter pelo menos 8 caracteres"
                        : null,

                    // Esconder a palavra-passe
                    obscureText: esconderPassword,

                    // Obter o valor da password escrito pelo user
                    controller: passwordInputController,

                    // Estilo dentro do campo da palavra-passe
                    style: StyleLoginScreen.estiloCampoDaPassword,

                    decoration: _decoracaoCampoDaPassword,
                  ),

                  const Padding(padding: EdgeInsets.only(bottom: 50)),

                  //* --> Botão Iniciar Sessão <--
                  SizedBox(
                    height: 65.0,
                    width: 335.0,
                    child: MaterialButton(
                      height: 50,
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: const Text(
                        "Iniciar sessão",
                        style: StyleLoginScreen.estiloBotaoIniciarSessao,
                      ),
                      onPressed: () async {
                        if (chaveDeFormulario.currentState!.validate()) {
                          /// Método de login com o provider
                          context.read<AuthModel>().login(
                                email: emailInputController.text.trim(),
                                password: passwordInputController.text.trim(),
                              );
                          // ignore: avoid_print
                          print('E-mail: ${emailInputController.text}');
                          // ignore: avoid_print
                          print('Password: ${passwordInputController.text}');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
