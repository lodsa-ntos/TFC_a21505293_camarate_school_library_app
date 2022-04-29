import 'package:camarate_school_library/screens/auth/registar.dart';
import 'package:camarate_school_library/services/auth_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

import '../../styles/style_login_screen.dart';
import '../../util/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //? Controladores para guardar o texto dos campos de texto do e-mail e da password.
  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();

  bool esconderPassword = true;
  bool _isLoading = false;

  //? Chave para identificar a validação do formulario
  final _chaveFormLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var _aCarregarAutenticacao = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        CircularProgressIndicator(),
        Text(" A autenticar... aguarde")
      ],
    );

    //? variável do campo da password
    final _decoracaoCampoDaPassword = InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      filled: true,
      labelText: "Palavra-passe",
      labelStyle: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w600,
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
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 150)),
                const Text(
                  "Login", //? titulo
                  textAlign: TextAlign.center,
                  style: StyleLoginScreen.estiloTituloLogin,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 45),
                Form(
                  key: _chaveFormLogin,
                  child: Column(
                    children: <Widget>[
                      //* E-mail
                      TextFormField(
                        validator: (email) =>
                            Validator.validarEmail(email: email),

                        // Obter o valor do email escrito pelo user
                        controller: _emailInputController,

                        keyboardType: TextInputType.emailAddress,

                        // Estilo dentro do campo de e-mail
                        style: StyleLoginScreen.estiloCampoDoEmail,

                        // Estilo da decoração do campo do e-mail
                        decoration: StyleLoginScreen.decoracaoCampoDoEmail,
                      ),

                      const SizedBox(height: 16.0),

                      //* Palavra-passe
                      TextFormField(
                        validator: (password) =>
                            Validator.validarPassword(password: password),

                        // Esconder a palavra-passe
                        obscureText: esconderPassword,

                        keyboardType: TextInputType.visiblePassword,

                        // Obter o valor da password escrito pelo user
                        controller: _passwordInputController,

                        // Estilo dentro do campo da palavra-passe
                        style: StyleLoginScreen.estiloCampoDaPassword,

                        decoration: _decoracaoCampoDaPassword,
                      ),

                      const Padding(padding: EdgeInsets.only(bottom: 15)),

                      //* --> Botão Iniciar Sessão <--
                      _isLoading
                          ? _aCarregarAutenticacao
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                      height: 50,
                                      textColor: Colors.white,
                                      color: Colors.blue,
                                      child: const Text(
                                        "Entrar",
                                        style: StyleLoginScreen
                                            .estiloBotaoIniciarSessao,
                                      ),
                                      onPressed: () async {
                                        if (_chaveFormLogin.currentState!
                                            .validate()) {
                                          fazerLogin();
                                          // ignore: avoid_print
                                          print(
                                            'E-mail: ${_emailInputController.text}',
                                          );
                                          // ignore: avoid_print
                                          print(
                                            'Password: ${_passwordInputController.text}',
                                          );
                                        }
                                      }),
                                ),
                              ],
                            ),

                      const Padding(padding: EdgeInsets.only(bottom: 35)),

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
                                      builder: (context) => const Registar(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  fazerLogin() async {
    setState(() => _isLoading = true);
    try {
      await context
          .read<AuthServices>()
          .login(_emailInputController.text, _passwordInputController.text)
          .then(
            (uid) => Fluttertoast.showToast(
              msg: "Logado com sucesso",
              backgroundColor: Colors.green,
            ),
          );

      //? Mensagens de erro
    } on AuthException catch (erro) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 10),
        content: Text(
          erro.mensagem,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }
}
