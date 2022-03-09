import 'package:camarate_school_library/Models/livro.dart';
import 'package:flutter/material.dart';

class RepositorioLivrosRequisitados extends ChangeNotifier {
  /// O campo privado de apoio ao [livro].
  late GerarLivro _livro;

  /// Interno, estado privado da minha lista de livros. Armazena os ids de cada livro.
  final List<int> _idsDoslivros = [];

  /// O livro atual. Usado para construir os livros de ids numéricos.
  GerarLivro get livro => _livro;

  set livro(GerarLivro novoLivro) {
    _livro = novoLivro;
    // Notifica, caso um livro forneça informações
    // diferente do anterior. Por exemplo, a disponibilidade de um livro
    // pode ter mudado.
    notifyListeners();
  }

  /// Lista de livros para o histórico.
  List<Livro> get livros =>
      _idsDoslivros.map((id) => _livro.getPorId(id)).toList();

  /// Adiciona o [livro] ao histórico.
  void add(Livro livro) {
    _idsDoslivros.add(livro.id);
    // Esta linha diz ao [ModeloDoLivro] que ele deve reconstruir os widgets que
    // dependem do --> notifyListeners.
    notifyListeners();
  }

  /// Remove o [livro] do histórico.
  void remove(Livro livro) {
    _idsDoslivros.remove(livro.id);
    // Esta linha diz aos widgets dependentes para reconstruir toda vez_
    // que o modelo alterado.
    notifyListeners();
  }
}
