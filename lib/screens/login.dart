import 'dart:async';
import 'dart:io';

import 'package:camarate_school_library/Models/view_models/conetividade.dart';
import 'package:camarate_school_library/Screens/repor_password/repor_palavra_passe.dart';
import 'package:camarate_school_library/Screens/sem_internet.dart';
import 'package:camarate_school_library/screens/menu_lateral/menu_lateral.dart';
import 'package:camarate_school_library/screens/registar.dart';
import 'package:camarate_school_library/services/auth_services.dart';
import 'package:camarate_school_library/util/navegador.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/pessoa.dart';
import '../styles/style_login_screen.dart';
import '../util/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //? Controladores para guardar o texto dos campos de texto do e-mail e da password.
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  bool esconderPassword = true;
  bool _isLoading = false;

  var _texto = '';

  //? Chave para identificar a validação do formulario
  final _chaveFormLogin = GlobalKey<FormState>();

  Pessoa pessoa = Pessoa();

  @override
  void initState() {
    super.initState();
    Provider.of<Conectividade>(context, listen: false).verificarLigacao();
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //? Simular chamada de espera para autenticar utilizador
    var _aCarregarAutenticacao = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Altera o loading, para os dispositivos android e ios
        Platform.isAndroid
            ? const CircularProgressIndicator()
            : const CupertinoActivityIndicator(),
        const Text(" A autenticar... aguarde")
      ],
    );

    // Impossibilita o utilizador de voltar para trás para a página splash screen (primeira página da app)
    return Consumer<Conectividade>(
      builder: (context, utilizador, child) {
        // ignore: unnecessary_null_comparison
        if (utilizador.isOnline != null) {
          return utilizador.isOnline ?? false
              ? WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: SafeArea(
                    child: Scaffold(
                      /// evitar que os widgets sejam redimensionados se o teclado aparecer
                      /// de repente e tapar tudo.
                      resizeToAvoidBottomInset: true,
                      body: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        reverse: true,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 50)),
                              Image.asset(
                                'assets/logotipo/ic_launcher_adaptive_fore.png',
                                filterQuality: FilterQuality.high,
                                width: 75,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Biblioteca Escolar", //? titulo
                                textAlign: TextAlign.center,
                                style: StyleLoginScreen
                                    .estiloTituloBibliotecaEscolar,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Camarate", //? titulo
                                textAlign: TextAlign.center,
                                style: StyleLoginScreen.estiloSubTituloCamarate,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 45),
                              Form(
                                key: _chaveFormLogin,
                                child: Column(
                                  children: <Widget>[
                                    //* E-mail
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextFormField(
                                        validator: (email) =>
                                            Validator.validarEmail(
                                                email: email),

                                        onChanged: (text) =>
                                            setState(() => _texto),

                                        // Obter o valor do email escrito pelo user
                                        controller: _emailInputController,

                                        keyboardType:
                                            TextInputType.emailAddress,

                                        // Estilo dentro do campo de e-mail
                                        style:
                                            StyleLoginScreen.estiloCampoDoEmail,

                                        cursorColor: Colors.grey.shade500,

                                        textCapitalization:
                                            TextCapitalization.words,
                                        textInputAction: TextInputAction.next,

                                        cursorHeight: 22,
                                        cursorWidth: 1.7,
                                        textAlign: TextAlign.start,

                                        // Estilo da decoração do campo do e-mail
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          labelText: "E-mail",
                                          labelStyle: GoogleFonts.roboto(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                127, 127, 127, 2),
                                          ),
                                          border: InputBorder.none,
                                          //filled: true,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 16.0),

                                    //* Palavra-passe
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextFormField(
                                        validator: (password) =>
                                            Validator.validarPassword(
                                                password: password),

                                        onChanged: (text) =>
                                            setState(() => _texto),

                                        // Esconder a palavra-passe
                                        obscureText: esconderPassword,

                                        keyboardType:
                                            TextInputType.visiblePassword,

                                        // Obter o valor da password escrito pelo user
                                        controller: _passwordInputController,

                                        // Estilo dentro do campo da palavra-passe
                                        style: StyleLoginScreen
                                            .estiloCampoDaPassword,

                                        cursorColor: Colors.grey.shade500,

                                        cursorHeight: 22,
                                        cursorWidth: 1.7,
                                        textAlign: TextAlign.start,

                                        textCapitalization:
                                            TextCapitalization.words,

                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 10,
                                          ),
                                          labelText: "Palavra-passe",
                                          labelStyle: GoogleFonts.roboto(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                127, 127, 127, 2),
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              setState(() {
                                                esconderPassword =
                                                    !esconderPassword;
                                              });
                                            },
                                            child: Icon(
                                              esconderPassword
                                                  ? FluentIcons
                                                      .eye_off_24_regular
                                                  : FluentIcons.eye_24_regular,
                                              color: esconderPassword
                                                  ? Colors.grey.shade500
                                                  : Color(0xff4285f4),
                                            ),
                                          ),
                                          border: InputBorder.none,
                                          //filled: true,
                                        ),
                                      ),
                                    ),

                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 15)),

                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            ReporPass(
                                                widget: ReporPalavraPasse()),
                                          );
                                        },
                                        child: Text(
                                          "Esqueceste-te da palavra-passe?",
                                          style: const TextStyle(
                                            color: Color(0xff2D55AB),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Distanciar
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 30)),

                                    //* --> Botão Iniciar Sessão <--
                                    _isLoading
                                        ? _aCarregarAutenticacao
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
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),

                                                  // Aqui controlo a disponibilidade do botao
                                                  // Se os campos não estiverem preenchidos o botão fica indisponivel
                                                  onPressed: _emailInputController
                                                              .value
                                                              .text
                                                              .isNotEmpty &&
                                                          _passwordInputController
                                                              .value
                                                              .text
                                                              .isNotEmpty
                                                      ? _submeterFormLogin
                                                      : null,
                                                  disabledColor:
                                                      Colors.blue.shade100,
                                                ),
                                              ),
                                            ],
                                          ),

                                    // Distanciar
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 25)),

                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: "Não tens uma conta? ",
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Registar(),
                                                  ),
                                                );
                                              },
                                            text: 'Regista-te.',
                                            style: const TextStyle(
                                              color: Color(0xff2D55AB),
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
                  ),
                )
              : SemInternet();
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  // Submeter pedido para o login
  Future _submeterFormLogin() async {
    return {
      fazerLogin(),
    };
  }

  fazerLogin() async {
    try {
      setState(() => _isLoading = true);

      await context
          .read<AuthServices>()
          .login(_emailInputController.text.trim(),
              _passwordInputController.text.trim())
          .then(
            (uid) => Fluttertoast.showToast(
              msg: "Logado com sucesso",
              backgroundColor: Colors.green,
            ),
          );

      await Navigator.push(
        context,
        MaterialPageRoute(
          //** Redireciona o utilizador para a página home
          builder: (context) => const MenuLateral(),
        ),
      );

      //? Mensagens de erro
    } on AuthException catch (erro) {
      setState(() => _isLoading = false);

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: AlertDialog(
              title: Text(
                'E-mail ou palavra-passe ' + '\n' + 'incorretos',
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              content: Text(erro.mensagem,
                  style: TextStyle(height: 1.5), textAlign: TextAlign.center),
              contentPadding: EdgeInsets.only(left: 28, right: 28, top: 10),
              actions: [
                Divider(color: Colors.grey),
                Center(
                  child: TextButton(
                    child: Text(
                      "Tentar novamente",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          //** Redireciona o utilizador para a página de login
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                  ),
                )
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          );
        },
      );
    }
  }
}
