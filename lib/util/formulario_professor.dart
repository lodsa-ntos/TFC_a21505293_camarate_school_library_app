import 'package:camarate_school_library/services/auth_services.dart';
import 'package:camarate_school_library/util/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/pessoa.dart';
import '../screens/login.dart';
import '../screens/home.dart';
import '../styles/style_login_screen.dart';

class FormularioProfessorState extends State<FormularioProfessor> {
  //? Chave para identificar a validação do formulario
  final _chaveFormRegisto = GlobalKey<FormState>();

  //? Esconder a password
  bool esconderPassword = true;

  bool _isLoading = false;

  //? Controladores para guardar o texto dos campos
  final nomeCompletoPessoaController = TextEditingController();
  final _turmaPessoaController = TextEditingController();

  //? Alcançar a instancia da abse de dados para autenticação do utilizador atual
  final _authProfessor = FirebaseAuth.instance;

  //? Simular chamada de espera para criar utilizador
  final _aCompletarDados = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      CircularProgressIndicator(),
      Text(" A completar dados... aguarde")
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const Padding(padding: EdgeInsets.only(bottom: 45)),
              const Text(
                "PROFESSORES", //? titulo
                textAlign: TextAlign.center,
                style: StyleRegistoScreen.estiloTituloRegisto,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 15),
              Form(
                key: _chaveFormRegisto,
                child: Column(
                  children: <Widget>[
                    //? Nome completo
                    TextFormField(
                      validator: (nome) =>
                          Validator.validarNomeCompleto(nome: nome),

                      // Obter o valor do email escrito pelo user
                      controller: nomeCompletoPessoaController,

                      // Estilo dentro do campo de e-mail
                      style: StyleRegistoScreen.estiloNomeCompleto,

                      // Estilo da decoração do campo do e-mail
                      decoration: StyleRegistoScreen.decoracaoNomeCompleto,
                    ),

                    const SizedBox(height: 16.0),

                    //? Turma
                    TextFormField(
                      validator: (turma) =>
                          Validator.validarTurma(turma: turma),

                      // Obter o valor do email escrito pelo user
                      controller: _turmaPessoaController,

                      // Estilo dentro do campo de e-mail
                      style: StyleRegistoScreen.estiloTurma,

                      // Estilo da decoração do campo do e-mail
                      decoration: StyleRegistoScreen.decoracaoTurma,
                    ),

                    const Padding(padding: EdgeInsets.only(bottom: 15)),

                    //? --> Botão Seguinte <--
                    _isLoading
                        ? _aCompletarDados
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: MaterialButton(
                                    height: 50,
                                    textColor: Colors.white,
                                    color: Colors.blue,
                                    child: const Text(
                                      "Seguinte",
                                      style: StyleRegistoScreen
                                          .estiloBotaoIniciarSessao,
                                    ),
                                    onPressed: () async {
                                      if (_chaveFormRegisto.currentState!
                                          .validate()) {
                                        saveProfessorNoFirestore();
                                      }
                                    }),
                              ),
                            ],
                          ),

                    const Padding(padding: EdgeInsets.only(bottom: 35)),

                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Já tens uma conta? ",
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
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                            text: ' Inicia sessão.',
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
    );
  }

  //* Guardar os dados do utilizador na base de dados do firestore
  saveProfessorNoFirestore() async {
    try {
      setState(() => _isLoading = true);
      // Instâcia par alcançar a base de dados firestore do firebase
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      // Utilizador atual que preencheu o formulário
      User? _utilizador = _authProfessor.currentUser;

      Pessoa _professor = Pessoa();

      _professor.nomeCompletoPessoa = nomeCompletoPessoaController.text.trim();

      _professor.turma = _turmaPessoaController.text.trim();

      // Chamada de espera de forma assincrona com o firebase para criar uma colecção de utilizadores
      // ... na base de dados firestore e preencher o JSON com os dados fornecidos pelo utilizador
      //... e enviar para a base de dados
      await firebaseFirestore
          .collection("Utilizadores")
          .where("uidPessoa", isEqualTo: _utilizador!.uid)
          .get()
          .then((value) => value.docs.forEach((element) {
                element.reference.update(
                  {
                    "nomeCompletoPessoa": _professor.nomeCompletoPessoa,
                  },
                );

                element.reference.update(
                  {
                    "turma": _professor.turma,
                  },
                );
              }));
      // mensagem de sucesso para user interface
      Fluttertoast.showToast(
        msg: "Conta criada com sucesso :) ",
        backgroundColor: Colors.orange,
      );

      // Redireciona o utilizador para a página home
      Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false,
      );
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

class FormularioProfessor extends StatefulWidget {
  const FormularioProfessor({Key? key}) : super(key: key);

  @override
  State<FormularioProfessor> createState() => FormularioProfessorState();
}
