import 'package:camarate_school_library/screens/login.dart';
import 'package:camarate_school_library/services/auth_services.dart';
import 'package:camarate_school_library/styles/style_login_screen.dart';
import 'package:camarate_school_library/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class _ReporPalavraPasseState extends State<ReporPalavraPasse> {
  final TextEditingController _emailInputController = TextEditingController();
  bool _isLoading = false;

  //? Chave para identificar a validação do formulario
  final _chaveFormLogin = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    validator: (email) => Validator.validarEmail(email: email),

                    // Obter o valor do email escrito pelo user
                    controller: _emailInputController,

                    keyboardType: TextInputType.emailAddress,

                    // Estilo dentro do campo de e-mail
                    style: StyleLoginScreen.estiloCampoDoEmail,

                    // Estilo da decoração do campo do e-mail
                    decoration: StyleLoginScreen.decoracaoCampoDoEmail,
                  ),
                ),

                SizedBox(height: 30),

                //? Butões
                ButtonTheme(
                  minWidth: 371.0,
                  child: MaterialButton(
                    height: 50,
                    textColor: Colors.white,
                    color: Color(0xff4285f4),
                    child: Text(
                      "Enviar",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Carmen',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.1,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () {
                      if (_chaveFormLogin.currentState!.validate()) {
                        pedirNovaPassword();
                        // ignore: avoid_print
                        print(
                          'E-mail: ${_emailInputController.text}',
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 8),
          content: Text(
            erro.mensagem,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  AppBar topoDaPaginaSobre(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/voltar.svg"),
        onPressed: () {
          Navigator.pop(context);
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
