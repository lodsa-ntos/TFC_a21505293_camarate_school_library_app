import 'package:camarate_school_library/Models/livro.dart';
import 'package:flutter/material.dart';

class VerificarLivroDetalhado extends ChangeNotifier {
  bool isEmprestado = false;
  final List<Livro> _livroRequisitado = [];

  void addLivroRequisitado(Livro livroRequisitado) {
    _livroRequisitado.add(livroRequisitado);
    // Isto vai dizer aos widgets que estão a espera deste modelo para reconstruir.
    notifyListeners();
  }
}
