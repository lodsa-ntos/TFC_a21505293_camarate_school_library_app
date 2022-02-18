import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/Screens/home/vista_pequena.dart';
import 'package:flutter/material.dart';

class VerificarRequisico extends ChangeNotifier {
  var livroReq = const VistaPequena();
  Livro? _livro;
  bool isRequisitado = false;

  addLivroRequisitado() async {
    livroReq.add({_livro?.imagemCapa, _livro!.autor});
    // ignore: avoid_print
    print(livroReq);
  }

  void setIsRequisitado(value) {
    isRequisitado = value;
    notifyListeners();
  }
}
