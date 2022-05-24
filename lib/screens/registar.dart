import 'package:camarate_school_library/models/pessoa.dart';
import 'package:camarate_school_library/screens/login.dart';
import 'package:camarate_school_library/util/formulario_professor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../services/auth_services.dart';
import '../styles/style_login_screen.dart';
import '../util/formulario_aluno.dart';
import '../util/validator.dart';

class _RegistarState extends State<Registar> {
  //? Chave para identificar a validação do formulario
  final _chaveFormRegisto = GlobalKey<FormState>();

  //? Esconder a password
  bool esconderPassword = true;

  bool _isLoading = false;

  //? Controladores para guardar o texto dos campos
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  final _numCartaoAlunoController = TextEditingController();
  final _nomeCompletoController = TextEditingController();
  final _numAlunoController = TextEditingController();
  final _anoController = TextEditingController();
  final _turmaController = TextEditingController();

  //? Alcançar a instancia da abse de dados para autenticação do utilizador atual
  final _auth = FirebaseAuth.instance;

  //? Simular chamada de espera para criar utilizador
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
                                          registarAluno();
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

  //* Registar Aluno na app
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

  //* Guardar os dados do Aluno na base de dados do firestore
  saveUserAlunoNoFirestore() async {
    // Instâcia par alcançar a base de dados firestore do firebase
    final databaseRef = FirebaseDatabase.instance.ref('utilizadores');

    // Utilizador atual que preencheu o formulário
    User? utilizador = _auth.currentUser;

    // Variável do tipo Pessoa para alcançar os atributos do professor
    Pessoa aluno = Pessoa();

    // Guardar todos os dados do aluno
    aluno.emailPessoa = utilizador!.email;
    aluno.uidPessoa = utilizador.uid;
    aluno.numCartaoPessoa = _numCartaoAlunoController.text.trim();
    aluno.passwordPessoa = _passwordInputController.text.trim();
    aluno.nomeCompletoPessoa = _nomeCompletoController.text.trim();
    aluno.numPessoa = _numAlunoController.text.trim();
    aluno.ano = _anoController.text.trim();
    aluno.turma = _turmaController.text.trim();

    // Chamada de espera de forma assincrona com o firebase para criar uma colecção de utilizadores
    // ... na base de dados realtime database e preencher o JSON com os dados fornecidos pelo utilizador
    //... e enviar para a base de dados
    await databaseRef.child(utilizador.uid).set(aluno.toJson());

    // mensagem de sucesso para user interface
    Fluttertoast.showToast(
      msg: "Conta criada com sucesso :) ",
      backgroundColor: Colors.orange,
    );

    // Redireciona o utilizador para a página home
    Navigator.pushAndRemoveUntil(
      (context),
      MaterialPageRoute(builder: (context) => FormularioAluno()),
      (route) => false,
    );
  }
}

class Registar extends StatefulWidget {
  const Registar({Key? key}) : super(key: key);

  @override
  State<Registar> createState() => _RegistarState();
}
