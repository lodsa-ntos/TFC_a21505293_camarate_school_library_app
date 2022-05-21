import 'package:camarate_school_library/models/utilizadores_model.dart';
import 'package:camarate_school_library/screens/login.dart';
import 'package:camarate_school_library/screens/home.dart';
import 'package:camarate_school_library/util/formulario_professor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../services/auth_services.dart';
import '../styles/style_login_screen.dart';
import '../util/formulario_aluno.dart';
import '../util/validator.dart';

class Registar extends StatefulWidget {
  const Registar({Key? key}) : super(key: key);

  @override
  State<Registar> createState() => _RegistarState();
}

class _RegistarState extends State<Registar> {
  //? Chave para identificar a validação do formulario
  final _chaveFormRegisto = GlobalKey<FormState>();

//? Esconder a password
  bool esconderPassword = true;

  bool _isLoading = false;

//? Controladores para guardar o texto dos campos
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  final _nomeCompletoController = TextEditingController();
  final _usernameController = TextEditingController();
  final _numCartaoAlunoController = TextEditingController();

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
                const Padding(padding: EdgeInsets.only(bottom: 45)),
                const Text(
                  "Regista-te", //? titulo
                  textAlign: TextAlign.center,
                  style: StyleRegistoScreen.estiloTituloRegisto,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 15),
                Form(
                  key: _chaveFormRegisto,
                  child: Column(
                    children: <Widget>[
                      //? Número do cartão
                      TextFormField(
                        validator: (numCartao) =>
                            Validator.validarNumeroCartao(numCartao: numCartao),

                        // Obter o valor do email escrito pelo user
                        controller: _numCartaoAlunoController,

                        // Estilo dentro do campo de e-mail
                        style: StyleRegistoScreen.estiloNumCartao,

                        // Estilo da decoração do campo do e-mail
                        decoration: StyleRegistoScreen.decoracaoNumCartao,
                      ),

                      const SizedBox(height: 16.0),

                      //? E-mail
                      TextFormField(
                        validator: (email) =>
                            Validator.validarEmail(email: email),

                        // Obter o valor do email escrito pelo user
                        controller: _emailInputController,

                        // Estilo dentro do campo de e-mail
                        style: StyleRegistoScreen.estiloCampoDoEmail,

                        // Estilo da decoração do campo do e-mail
                        decoration: StyleRegistoScreen.decoracaoCampoDoEmail,
                      ),

                      const SizedBox(height: 16.0),

                      //? Palavra-passe
                      TextFormField(
                        validator: (password) =>
                            Validator.validarPasswordRegisto(
                                password: password),

                        // Esconder a palavra-passe
                        obscureText: esconderPassword,

                        // Obter o valor da password escrito pelo user
                        controller: _passwordInputController,

                        // Estilo dentro do campo da palavra-passe
                        style: StyleRegistoScreen.estiloCampoDaPassword,

                        decoration: _decoracaoCampoDaPassword,
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
                                          if (_numCartaoAlunoController.text
                                              .trim()
                                              .contains('a')) {
                                            registarAluno();
                                          } else if (_numCartaoAlunoController
                                              .text
                                              .trim()
                                              .contains('p')) {
                                            registarProfessor();
                                          }
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
      ),
    );
  }

  //* Registar utilizador na app
  registarAluno() async {
    setState(() => _isLoading = true);
    try {
      await context
          .read<AuthServices>()
          .registar(_emailInputController.text, _passwordInputController.text)
          .then((value) => {saveUserAlunoNoFirestore()});
      //* Mensagens de erro
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

  //* Guardar os dados do utilizador na base de dados do firestore
  saveUserAlunoNoFirestore() async {
    // Instâcia par alcançar a base de dados firestore do firebase
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Utilizador atual que preencheu o formulário
    User? utilizador = _auth.currentUser;

    // Variável do tipo aluno para alcançar os atributos do aluno
    Pessoa alunoModel = Pessoa();

    // Guardar todos os valores do aluno
    alunoModel.emailPessoa = utilizador!.email;
    alunoModel.uidPessoa = utilizador.uid;
    alunoModel.numCartaoPessoa = _numCartaoAlunoController.text.trim();
    alunoModel.passwordPessoa = _passwordInputController.text.trim();

    // Chamada de espera de forma assincrona com o firebase para criar uma colecção de utilizadores
    // ... na base de dados firestore e preencher o JSON com os dados fornecidos pelo utilizador
    //... e enviar para a base de dados
    await firebaseFirestore
        .collection("Utilizadores")
        .doc(utilizador.uid)
        .set(alunoModel.toJson());
    // mensagem de sucesso para user interface
    Fluttertoast.showToast(
      msg: "Bem-vindo aluno :) ",
      backgroundColor: Colors.green,
    );

    // Redireciona o utilizador para a página home
    Navigator.pushAndRemoveUntil(
      (context),
      MaterialPageRoute(builder: (context) => FormularioAluno()),
      (route) => false,
    );
  }

  //? Registar professor na app
  registarProfessor() async {
    setState(() => _isLoading = true);
    try {
      await context
          .read<AuthServices>()
          .registar(_emailInputController.text, _passwordInputController.text)
          .then((value) => {saveUserProfessorNoFirestore()});
      //* Mensagens de erro
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

  //? Guardar os dados do professor na base de dados do firestore
  saveUserProfessorNoFirestore() async {
    // Instâcia par alcançar a base de dados firestore do firebase
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Utilizador atual que preencheu o formulário
    User? userProfessor = _auth.currentUser;

    // Variável do tipo Pessoa para alcançar os atributos do professor
    Pessoa professorModel = Pessoa();

    // Guardar todos os valores do Professor
    professorModel.emailPessoa = userProfessor!.email;
    professorModel.uidPessoa = userProfessor.uid;
    professorModel.numCartaoPessoa = _numCartaoAlunoController.text.trim();
    professorModel.passwordPessoa = _passwordInputController.text.trim();

    // Chamada de espera de forma assincrona com o firebase para criar uma colecção de utilizadores
    // ... na base de dados firestore e preencher o JSON com os dados fornecidos pelo utilizador
    //... e enviar para a base de dados
    await firebaseFirestore
        .collection("Utilizadores")
        .doc(userProfessor.uid)
        .set(professorModel.toJson());
    // mensagem de sucesso para user interface
    Fluttertoast.showToast(
      msg: "Bem-vindo professor :) ",
      backgroundColor: Colors.orange,
    );

    // Redireciona o utilizador para a página home
    Navigator.pushAndRemoveUntil(
      (context),
      MaterialPageRoute(builder: (context) => const FormularioProfessor()),
      (route) => false,
    );
  }
}
