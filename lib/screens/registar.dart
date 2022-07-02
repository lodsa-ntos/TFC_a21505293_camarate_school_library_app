import 'dart:io';
import 'dart:async';

import 'package:camarate_school_library/models/pessoa.dart';
import 'package:camarate_school_library/screens/menu_lateral/menu_lateral.dart';
import 'package:camarate_school_library/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/auth_services.dart';
import '../styles/style_login_screen.dart';
import '../util/validator.dart';

class _RegistarState extends State<Registar> {
  //? Chave para identificar a validação do formulario
  final _chaveFormRegisto = GlobalKey<FormState>();

  var _texto = '';

  //? Esconder a password
  bool esconderPassword = true;

  bool _isLoading = false;

  FocusNode myFocusNode = new FocusNode();

  //? Controladores para guardar o texto dos campos
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  final _numCartaoAlunoController = TextEditingController();
  final _nomeCompletoController = TextEditingController();
  final _numAlunoController = TextEditingController();
  final _anoController = TextEditingController();
  final _turmaController = TextEditingController();

  final valorAno = ValueNotifier('');

  final anoOpcoes = ['7º', '8º', '9º', '10º', '11º', '12º'];

  final valorTurma = ValueNotifier('');

  final turmaOpcoes = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  final valorNumeroPessaos = ValueNotifier('');

  final numOpcoes = [for (var i = 1; i <= 30; i++) i.toString()];

  //? Alcançar a instancia da abse de dados para autenticação do utilizador atual
  final _auth = FirebaseAuth.instance;

  //? Simular chamada de espera para criar utilizador
  final _aCriarUtilizador = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Platform.isAndroid
          ? const CircularProgressIndicator()
          : const CupertinoActivityIndicator(),
      const Text(" A criar utilizador... aguarde")
    ],
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          /// evitar que os wid
          /// gets sejam redimensionados se o teclado aparecer
          /// de repente e tapar tudo.
          resizeToAvoidBottomInset: true,
          body: ListView(
            padding: const EdgeInsets.only(left: 2.0, right: 2.0),
            shrinkWrap: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(padding: EdgeInsets.only(bottom: 30)),
                    Text(
                      "Regista-te", //? titulo
                      style: StyleRegistoScreen.estiloTituloRegisto,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "E embarca nas viajens da leitura na tua biblioteca!", //? titulo
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    //? Formulário
                    const Padding(padding: EdgeInsets.only(bottom: 30)),
                    Form(
                      key: _chaveFormRegisto,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Número do cartão',
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(127, 127, 127, 2),
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            validator: (numCartao) =>
                                Validator.validarNumeroCartao(
                                    numCartao: numCartao),

                            onChanged: (text) => setState(() => _texto),

                            // Obter o valor do email escrito pelo user
                            controller: _numCartaoAlunoController,

                            keyboardType: TextInputType.text,

                            style: StyleRegistoScreen.estiloNumCartao,

                            cursorColor: Colors.grey.shade500,

                            cursorHeight: 22,
                            cursorWidth: 1.7,
                            textAlign: TextAlign.start,

                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,

                            // Estilo da decoração do campo do e-mail
                            decoration: StyleRegistoScreen.decoracaoNumCartao,
                          ),

                          const Padding(padding: EdgeInsets.only(bottom: 15)),

                          Text(
                            'Nome completo',
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(127, 127, 127, 2),
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            validator: (nome) =>
                                Validator.validarNomeCompleto(nome: nome),

                            onChanged: (text) => setState(() => _texto),

                            // Obter o valor do email escrito pelo user
                            controller: _nomeCompletoController,

                            keyboardType: TextInputType.text,

                            style: StyleRegistoScreen.estiloNomeCompleto,

                            cursorColor: Colors.grey.shade500,

                            cursorHeight: 22,
                            cursorWidth: 1.7,
                            textAlign: TextAlign.start,

                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,

                            // Estilo da decoração do campo do e-mail
                            decoration:
                                StyleRegistoScreen.decoracaoNomeCompleto,
                          ),

                          const Padding(padding: EdgeInsets.only(bottom: 15)),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ano',
                                    style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(127, 127, 127, 2),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  ValueListenableBuilder(
                                    valueListenable: valorAno,
                                    builder: (BuildContext context,
                                        String value, _) {
                                      return SizedBox(
                                        width: 80,
                                        height: 55,
                                        child: DropdownButtonFormField(
                                          isDense: true,
                                          isExpanded: true,
                                          icon: Icon(FluentIcons
                                              .caret_down_12_regular),
                                          hint: Text('7º'),
                                          value: (value.isEmpty) ? null : value,
                                          onChanged: (escolha) {
                                            valorAno.value = escolha.toString();
                                            _anoController.text =
                                                valorAno.value.toString();
                                          },
                                          items: anoOpcoes
                                              .map(
                                                (opcao) => DropdownMenuItem(
                                                  value: opcao,
                                                  child: Text(opcao),
                                                ),
                                              )
                                              .toList(),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 15)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Turma',
                                    style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(127, 127, 127, 2),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  ValueListenableBuilder(
                                    valueListenable: valorTurma,
                                    builder: (BuildContext context,
                                        String value, _) {
                                      return SizedBox(
                                        width: 100,
                                        height: 55,
                                        child: DropdownButtonFormField(
                                          isDense: true,
                                          isExpanded: true,
                                          icon: Icon(FluentIcons
                                              .caret_down_12_regular),
                                          hint: Text('A'),
                                          value: (value.isEmpty) ? null : value,
                                          onChanged: (escolha) {
                                            valorTurma.value =
                                                escolha.toString();
                                            _turmaController.text =
                                                valorTurma.value.toString();
                                          },
                                          items: turmaOpcoes
                                              .map(
                                                (opcao) => DropdownMenuItem(
                                                  value: opcao,
                                                  child: Text(opcao),
                                                ),
                                              )
                                              .toList(),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 15)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nº',
                                    style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(127, 127, 127, 2),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  ValueListenableBuilder(
                                    valueListenable: valorNumeroPessaos,
                                    builder: (BuildContext context,
                                        String value, _) {
                                      return SizedBox(
                                        width: 80,
                                        height: 55,
                                        child: DropdownButtonFormField(
                                          isDense: true,
                                          isExpanded: true,
                                          icon: Icon(FluentIcons
                                              .caret_down_12_regular),
                                          hint: Text('1'),
                                          value: (value.isEmpty) ? null : value,
                                          onChanged: (escolha) {
                                            valorNumeroPessaos.value =
                                                escolha.toString();
                                            _numAlunoController.text =
                                                valorNumeroPessaos.value
                                                    .toString();
                                          },
                                          items: numOpcoes
                                              .map(
                                                (opcao) => DropdownMenuItem(
                                                  value: opcao,
                                                  child: Text(opcao),
                                                ),
                                              )
                                              .toList(),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const Padding(padding: EdgeInsets.only(bottom: 15)),

                          Text(
                            'E-mail',
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(127, 127, 127, 2),
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            validator: (email) =>
                                Validator.validarEmail(email: email),

                            onChanged: (text) => setState(() => _texto),

                            // Obter o valor do email escrito pelo user
                            controller: _emailInputController,

                            keyboardType: TextInputType.emailAddress,

                            style: StyleRegistoScreen.estiloCampoDoEmail,

                            cursorColor: Colors.grey.shade500,

                            cursorHeight: 22,
                            cursorWidth: 1.7,
                            textAlign: TextAlign.start,

                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,

                            // Estilo da decoração do campo do e-mail
                            decoration:
                                StyleRegistoScreen.decoracaoCampoDoEmail,
                          ),

                          const Padding(padding: EdgeInsets.only(bottom: 15)),

                          Text(
                            'Palavra-passe',
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(127, 127, 127, 2),
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            validator: (password) =>
                                Validator.validarPasswordRegisto(
                                    password: password),

                            onChanged: (text) => setState(() => _texto),

                            // Esconder a palavra-passe
                            obscureText: esconderPassword,

                            keyboardType: TextInputType.visiblePassword,

                            // Obter o valor da password escrito pelo user
                            controller: _passwordInputController,

                            // Estilo dentro do campo da palavra-passe
                            style: StyleLoginScreen.estiloCampoDaPassword,

                            cursorColor: Colors.grey.shade500,

                            cursorHeight: 22,
                            cursorWidth: 1.7,
                            textAlign: TextAlign.start,

                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,

                            // Estilo da decoração do campo do e-mail
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              labelStyle: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(127, 127, 127, 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(
                                    () {
                                      esconderPassword = !esconderPassword;
                                    },
                                  );
                                },
                                child: Icon(
                                  esconderPassword
                                      ? FluentIcons.eye_off_24_regular
                                      : FluentIcons.eye_24_regular,
                                  color: esconderPassword
                                      ? Colors.grey.shade500
                                      : Color(0xff4285f4),
                                ),
                              ),
                            ),
                          ),

                          const Padding(padding: EdgeInsets.only(bottom: 20)),

                          //? --> Botão Seguinte <--
                          _isLoading
                              ? _aCriarUtilizador
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
                                          "Seguinte",
                                          style: StyleLoginScreen
                                              .estiloBotaoIniciarSessao,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        onPressed: _numCartaoAlunoController
                                                    .value.text.isNotEmpty &&
                                                _nomeCompletoController
                                                    .value.text.isNotEmpty &&
                                                _anoController
                                                    .value.text.isNotEmpty &&
                                                _turmaController
                                                    .value.text.isNotEmpty &&
                                                _numAlunoController
                                                    .value.text.isNotEmpty &&
                                                _emailInputController
                                                    .value.text.isNotEmpty &&
                                                _passwordInputController
                                                    .value.text.isNotEmpty
                                            ? _submeterFormulario
                                            : null,
                                        disabledColor: Colors.blue.shade100,
                                      ),
                                    ),
                                  ],
                                ),

                          const Padding(padding: EdgeInsets.only(bottom: 30)),

                          Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "Já tens uma conta? ",
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
                                                const LoginScreen(),
                                          ),
                                        );
                                      },
                                    text: ' Inicia sessão.',
                                    style: const TextStyle(
                                      color: Color(0xff2D55AB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 50)),
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

  Future _submeterFormulario() async {
    return {
      if (_chaveFormRegisto.currentState!.validate()) {registarAluno()}
    };
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
    Pessoa _pessoa = Pessoa();

    // Guardar todos os dados do aluno
    _pessoa.emailPessoa = utilizador!.email;
    _pessoa.uidPessoa = utilizador.uid;
    _pessoa.numCartaoPessoa = _numCartaoAlunoController.text.trim();
    _pessoa.passwordPessoa = _passwordInputController.text.trim();
    _pessoa.nomeCompletoPessoa = _nomeCompletoController.text.trim();
    _pessoa.numPessoa = _numAlunoController.text.trim();
    _pessoa.ano = _anoController.text.trim();
    _pessoa.turma = _turmaController.text.trim();

    // Chamada de espera de forma assincrona com o firebase para criar uma colecção de utilizadores
    // ... na base de dados realtime database e preencher o JSON com os dados fornecidos pelo utilizador
    //... e enviar para a base de dados
    await databaseRef.child(utilizador.uid).set(_pessoa.toJson());

    // mensagem de sucesso para user interface
    Fluttertoast.showToast(
      msg: "Conta criada com sucesso :) ",
      backgroundColor: Colors.orange,
    );

    // Redireciona o utilizador para a página home
    Navigator.pushAndRemoveUntil(
      (context),
      MaterialPageRoute(builder: (context) => const MenuLateral()),
      (route) => false,
    );
  }
}

class Registar extends StatefulWidget {
  const Registar({Key? key}) : super(key: key);

  @override
  State<Registar> createState() => _RegistarState();
}
