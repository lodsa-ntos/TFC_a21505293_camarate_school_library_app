import 'package:camarate_school_library/Models/Auth/auth_model.dart';
import 'package:camarate_school_library/Screens/Home/home.dart';
import 'package:camarate_school_library/Styles/style_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/src/provider.dart';

bool _emailErrado = false;
bool _passwordErrado = false;
String _messagemErro = '';

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
  bool isInProgresso = false;
  final chaveDeFormulario = GlobalKey<FormState>();

  @override
  void initState() {
    emailInputController = TextEditingController();
    emailInputController.addListener(() {
      setState(() {});
    });
    passwordInputController = TextEditingController();
    passwordInputController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    emailInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }

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

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: ModalProgressHUD(
          inAsyncCall: isInProgresso,
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
                      validator: (val) => ValidadorDeEmail.validar(val!),

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
                      validator: (val) => ValidadorDaPassword.validar(val!),

                      // Esconder a palavra-passe
                      obscureText: esconderPassword,

                      // Obter o valor da password escrito pelo user
                      controller: passwordInputController,

                      // Estilo dentro do campo da palavra-passe
                      style: StyleLoginScreen.estiloCampoDaPassword,

                      decoration: _decoracaoCampoDaPassword,
                    ),

                    Center(
                      child: Text(_messagemErro),
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
                            try {
                              await Provider.of<AuthModel>(context,
                                      listen: false)
                                  .login(
                                email: emailInputController.text.trim(),
                                password: passwordInputController.text.trim(),
                              );

                              // ignore: avoid_print
                              print('E-mail: ${emailInputController.text}');
                              // ignore: avoid_print
                              print(
                                  'Password: ${passwordInputController.text}');

                              _messagemErro = 'Nenhum e-mail encontrado';
                            } on FirebaseAuthException catch (error) {
                              _messagemErro = error.message!;
                            }
                            setState(() {});
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
      ),
    );
  }

  Future _mostrarMensagemErro(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: const Text("Conta não existe"),
          content: Text(_message),
          actions: <Widget>[
            TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}

class ValidadorDeEmail {
  static String? validar(String value) {
    if (value.isEmpty) {
      return "O e-mail não pode ser vazio";
    } else if ((RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value) &&
        !_emailErrado)) {
      return null;
    } else {
      if (_emailErrado == true) {
        return "Nenhum e-mail encontrado";
      } else {
        return "Por favor, introduza um email válido";
      }
    }
  }
}

class ValidadorDaPassword {
  static String? validar(String value) {
    if (value.isEmpty) {
      return "A palavra-passe não pode ser vazia";
    } else if (value.length > 6 && !_passwordErrado) {
      return null;
    } else {
      if (_passwordErrado == true) {
        return "A tua palavra-passe estava incorreta. Verifica-a novamente.";
      } else {
        return "A palavra-passe deve ter mais de 8 caracteres";
      }
    }
  }
}
