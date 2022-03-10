import 'package:camarate_school_library/Models/livro.dart';
import 'package:flutter/material.dart';

class HomeRequisitarProvider extends ChangeNotifier {
  /// Variavel privada [livro], para chamar e guardar o livro por id.
  late GerarLivro _livro;

  /// Lista privada para armazenar os ids de cada livro.
  final List<int> _idsDoslivros = [];

  /// Com esta [_livro] depois consigo obter os livros por ids numéricos.
  GerarLivro get livro => _livro;

  /// Lista para guardar os livros por id e transformar em lista.
  List<Livro> get livros =>
      _idsDoslivros.map((id) => _livro.getPorId(id)).toList();

  /// Adicionar o [livro].
  void addLivroRequisitado(Livro livro) {
    _idsDoslivros.add(livro.id);
    // Esta linha diz ao [ModeloDoLivro] que ele deve reconstruir os widgets que
    // dependem do --> notifyListeners.
    notifyListeners();
  }

  set livro(GerarLivro novoLivro) {
    _livro = novoLivro;
    // Notifica, caso um livro forneça informações
    // diferente do anterior. Por exemplo, a disponibilidade de um livro
    // pode ter mudado.
    notifyListeners();
  }
}
