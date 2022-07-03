import 'dart:io';

import 'package:camarate_school_library/Screens/login.dart';

import 'package:camarate_school_library/services/auth_services.dart';
import 'package:camarate_school_library/styles/style_login_screen.dart';
import 'package:camarate_school_library/util/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class _ReporPalavraPasseState extends State<ReporPalavraPasse> {
  final _emailInputController = TextEditingController();
  bool _isLoading = false;
  var _texto = '';

  //? Chave para identificar a validação do formulario
  final _chaveFormLogin = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //? Simular chamada de espera para autenticar utilizador
    var _aProcessarPedido = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Altera o loading, para os dispositivos android e ios
        Platform.isAndroid
            ? const CircularProgressIndicator()
            : const CupertinoActivityIndicator(),
        const Text(" A processar... aguarde")
      ],
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: topoDaPaginaSobre(context),
      body: SingleChildScrollView(
        reverse: true,
        child: SizedBox(
          width: double.infinity,
          child: Form(
            key: _chaveFormLogin,
            child: Column(
              children: [
                SizedBox(height: 60),
                Text(
                  'Repor palavra-passe',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline6!.color,
                    fontFamily: 'Montserrat',
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Insere o e-mail associado à sua conta e vamos enviar-lhe um e-mail ou SMS para repor a sua palavra-passe.',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline6!.color,
                      height: 1.5,
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      validator: (email) =>
                          Validator.validarEmail(email: email),

                      onChanged: (text) => setState(() => _texto),

                      // Obter o valor do email escrito pelo user
                      controller: _emailInputController,

                      keyboardType: TextInputType.emailAddress,

                      // Estilo dentro do campo de e-mail
                      style: StyleLoginScreen.estiloCampoDoEmail,

                      cursorColor: Colors.grey.shade500,

                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,

                      cursorHeight: 22,
                      cursorWidth: 1.7,
                      textAlign: TextAlign.start,

                      // Estilo da decoração do campo do e-mail
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        labelText: "E-mail",
                        labelStyle: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(127, 127, 127, 2),
                        ),
                        border: InputBorder.none,
                        //filled: true,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                ///* --> Botão Iniciar Sessão <--
                _isLoading
                    ? _aProcessarPedido
                    : Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: MaterialButton(
                                height: 50,
                                textColor: Colors.white,
                                color: Colors.blue,
                                child: const Text(
                                  "Enviar",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Carmen',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.1,
                                    color: Colors.white,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),

                                // Aqui controlo a disponibilidade do botao
                                // Se os campos não estiverem preenchidos o botão fica indisponivel
                                onPressed:
                                    _emailInputController.value.text.isNotEmpty
                                        ? _submeterPedidoPassword
                                        : null,
                                disabledColor: Colors.blue.shade100,
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

  // Submeter pedido para o login
  Future _submeterPedidoPassword() async {
    return {pedirNovaPassword()};
  }

  pedirNovaPassword() async {
    try {
      setState(() => _isLoading = true);

      await context
          .read<AuthServices>()
          .ReporPassword(_emailInputController.text.trim())
          .then((uid) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(
                    'O link para reposição da palavra-passe foi enviado. Verifique o seu e-mail.',
                  ),
                  actions: [
                    TextButton(
                      child: Text("Ok"),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            //** Redireciona o utilizador para a página de detalhes do livro */
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    )
                  ],
                );
              }));

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
                'E-mail ' + '\n' + 'incorreto',
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
                          builder: (context) => const ReporPalavraPasse(),
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

  AppBar topoDaPaginaSobre(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/voltar.svg"),
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
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}

class ReporPalavraPasse extends StatefulWidget {
  const ReporPalavraPasse({Key? key}) : super(key: key);

  @override
  State<ReporPalavraPasse> createState() => _ReporPalavraPasseState();
}
