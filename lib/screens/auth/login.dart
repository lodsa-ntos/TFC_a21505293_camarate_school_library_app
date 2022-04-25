import 'package:camarate_school_library/Styles/style_login_screen.dart';
import 'package:camarate_school_library/models/view_models/auth_view_model.dart';
import 'package:camarate_school_library/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

import '../../Database/base_de_dados.dart';
import '../../util/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  /// Controladores para guardar o texto dos campos de texto do e-mail
  /// e da password.
  TextEditingController _emailInputController = TextEditingController();
  TextEditingController _passwordInputController = TextEditingController();

  bool esconderPassword = true;
  final _chaveDeFormulario = GlobalKey<FormState>();

  @override
  void initState() {
    _emailInputController = TextEditingController();
    _passwordInputController = TextEditingController();
    super.initState();
  }

  /// dispose para libertar a memória alocada das variáveis ​​
  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fazerLigacao = BaseDeDados();
    // variável do campo password
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

    return SafeArea(
      child: Scaffold(
        /// evitar que os widgets sejam redimensionados se o teclado aparecer
        /// de repente e tapar tudo.
        resizeToAvoidBottomInset: true,
        body: FutureBuilder(
          future: fazerLigacao.initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: StyleLoginScreen.estiloTituloLogin,
                    ),
                    const SizedBox(height: 45),
                    Form(
                      key: _chaveDeFormulario,
                      child: Column(
                        children: <Widget>[
                          //* E-mail
                          TextFormField(
                            validator: (email) =>
                                Validator.validarEmail(email: email),

                            // Obter o valor do email escrito pelo user
                            controller: _emailInputController,

                            // Estilo dentro do campo de e-mail
                            style: StyleLoginScreen.estiloCampoDoEmail,

                            // Estilo da decoração do campo do e-mail
                            decoration: StyleLoginScreen.decoracaoCampoDoEmail,
                          ),

                          const SizedBox(height: 8.0),

                          //* Palavra-passe
                          TextFormField(
                            validator: (password) =>
                                Validator.validarPassword(password: password),

                            // Esconder a palavra-passe
                            obscureText: esconderPassword,

                            // Obter o valor da password escrito pelo user
                            controller: _passwordInputController,

                            // Estilo dentro do campo da palavra-passe
                            style: StyleLoginScreen.estiloCampoDaPassword,

                            decoration: _decoracaoCampoDaPassword,
                          ),

                          const SizedBox(height: 24.0),

                          //* --> Botão Iniciar Sessão <--
                          _isLoading
                              ? const CircularProgressIndicator()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: MaterialButton(
                                          height: 50,
                                          textColor: Colors.white,
                                          color: Colors.blue,
                                          child: const Text(
                                            "Iniciar sessão",
                                            style: StyleLoginScreen
                                                .estiloBotaoIniciarSessao,
                                          ),
                                          onPressed: () async {
                                            if (_chaveDeFormulario.currentState!
                                                .validate()) {
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              try {
                                                _chaveDeFormulario.currentState
                                                    ?.save();
                                                await AuthModel.login(
                                                  email: _emailInputController
                                                      .text
                                                      .trim(),
                                                  password:
                                                      _passwordInputController
                                                          .text
                                                          .trim(),
                                                );

                                                // ignore: avoid_print
                                                print(
                                                    'E-mail: ${_emailInputController.text}');
                                                // ignore: avoid_print
                                                print(
                                                    'Password: ${_passwordInputController.text}');

                                                setState(() {
                                                  _isLoading = false;
                                                });
                                              } on FirebaseAuthException catch (error) {
                                                error.message!;
                                                print(error);
                                              }

                                              setState(() {
                                                _isLoading = false;
                                              });
                                            }
                                          }),
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
