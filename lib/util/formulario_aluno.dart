import 'package:camarate_school_library/util/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/auth/login.dart';
import '../screens/home/home.dart';
import '../styles/style_login_screen.dart';

class FormularioAluno extends StatefulWidget {
  const FormularioAluno({Key? key}) : super(key: key);

  @override
  State<FormularioAluno> createState() => FormularioAlunoState();
}

class FormularioAlunoState extends State<FormularioAluno> {
  //? Chave para identificar a validação do formulario
  final _chaveFormRegisto = GlobalKey<FormState>();

//? Esconder a password
  bool esconderPassword = true;

  bool _isLoading = false;

//? Controladores para guardar o texto dos campos
  final _nomeCompletoController = TextEditingController();
  final _usernameController = TextEditingController();
  final _numAlunoController = TextEditingController();
  final _anoController = TextEditingController();
  final _turmaController = TextEditingController();

  //! Alcançar a instancia da abse de dados para autenticação do utilizador atual
  final _auth = FirebaseAuth.instance;

//! Simular chamada de espera para criar utilizador
  final _aCriarUtilizador = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      CircularProgressIndicator(),
      Text(" A criar utilizador... aguarde")
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
                "ALUNOS", //? titulo
                textAlign: TextAlign.center,
                style: StyleRegistoScreen.estiloTituloRegisto,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 15),
              Form(
                key: _chaveFormRegisto,
                child: Column(
                  children: <Widget>[
                    //? Nome de utilizador
                    TextFormField(
                      validator: (username) =>
                          Validator.validarUsername(username: username),

                      // Obter o valor do email escrito pelo user
                      controller: _usernameController,

                      // Estilo dentro do campo de e-mail
                      style: StyleRegistoScreen.estiloNomeUtilizador,

                      // Estilo da decoração do campo do e-mail
                      decoration: StyleRegistoScreen.decoracaoNomeUtilizador,
                    ),

                    const SizedBox(height: 16.0),

                    //? Nome próprio e apelido
                    TextFormField(
                      validator: (nome) =>
                          Validator.validarNomeCompleto(nome: nome),

                      // Obter o valor do email escrito pelo user
                      controller: _nomeCompletoController,

                      // Estilo dentro do campo de e-mail
                      style: StyleRegistoScreen.estiloNomeCompleto,

                      // Estilo da decoração do campo do e-mail
                      decoration: StyleRegistoScreen.decoracaoNomeCompleto,
                    ),

                    const SizedBox(height: 16.0),

                    //? Número do aluno
                    TextFormField(
                      validator: (numAluno) =>
                          Validator.validarAno(ano: numAluno),

                      keyboardType: TextInputType.number,

                      maxLength: 2,

                      // Obter o valor do email escrito pelo user
                      controller: _numAlunoController,

                      // Estilo dentro do campo de e-mail
                      style: StyleRegistoScreen.estiloNumeroAluno,

                      // Estilo da decoração do campo do e-mail
                      decoration: StyleRegistoScreen.decoracaoNumeroAluno,
                    ),

                    const SizedBox(height: 16.0),

                    //? Ano
                    TextFormField(
                      validator: (ano) => Validator.validarAno(ano: ano),

                      // Obter o valor do email escrito pelo user
                      controller: _anoController,

                      keyboardType: TextInputType.number,

                      maxLength: 2,

                      // Estilo dentro do campo de e-mail
                      style: StyleRegistoScreen.estiloAno,

                      // Estilo da decoração do campo do e-mail
                      decoration: StyleRegistoScreen.decoracaoAno,
                    ),

                    const SizedBox(height: 16.0),

                    //? Turma
                    TextFormField(
                      validator: (turma) =>
                          Validator.validarTurma(turma: turma),

                      // Obter o valor do email escrito pelo user
                      controller: _turmaController,

                      // Estilo dentro do campo de e-mail
                      style: StyleRegistoScreen.estiloTurma,

                      // Estilo da decoração do campo do e-mail
                      decoration: StyleRegistoScreen.decoracaoTurma,
                    ),

                    const Padding(padding: EdgeInsets.only(bottom: 15)),

                    //? --> Botão Seguinte <--
                    _isLoading
                        ? _aCriarUtilizador
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
                                        saveUtilizadorAlunoNoFirestore();
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

  //! Guardar os dados do utilizador na base de dados do firestore
  saveUtilizadorAlunoNoFirestore() async {
    // Instâcia par alcançar a base de dados firestore do firebase
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Utilizador atual que preencheu o formulário
    User? utilizador = _auth.currentUser;

    // Chamada de espera de forma assincrona com o firebase para criar uma colecção de utilizadores
    // ... na base de dados firestore e preencher o JSON com os dados fornecidos pelo utilizador
    //... e enviar para a base de dados
    await firebaseFirestore
        .collection("Utilizadores")
        .where("uidAluno", isEqualTo: utilizador!.uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.update(
                {"nomeUtilizadorAluno": _usernameController.text.trim()},
              );

              element.reference.update(
                {"nomeCompletoAluno": _nomeCompletoController.text.trim()},
              );

              element.reference.update(
                {"numAluno": _numAlunoController.text.trim()},
              );

              element.reference.update(
                {"ano": _anoController.text.trim()},
              );

              element.reference.update(
                {"turma": _turmaController.text.trim()},
              );
            }));
    // mensagem de sucesso para user interface
    Fluttertoast.showToast(
      msg: "Conta criada com sucesso :) ",
      backgroundColor: Colors.green,
    );

    // Redireciona o utilizador para a página home
    Navigator.pushAndRemoveUntil(
      (context),
      MaterialPageRoute(builder: (context) => const Home()),
      (route) => false,
    );
  }
}
