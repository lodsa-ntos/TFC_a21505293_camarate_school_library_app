import 'package:camarate_school_library/Models/livro.dart';
import 'package:flutter/material.dart';

class LivroRequisitadoModel extends ChangeNotifier {
  //** Variável privada [livro], para chamar e guardar o livro por id. */
  late LivroModel _listaDeLivros;

  //** Lista privada para armazenar os ids de cada livro */.
  final List<int> _idsDoslivros = [];

  //** Com esta variável [_livro] obtenho os livros por ids */
  LivroModel get livro => _listaDeLivros;

  //** Lista para guardar os livros por id na lista de _idsDoslivros no formato de uma lista. */
  List<Livro> get livros =>
      _idsDoslivros.map((id) => _listaDeLivros.getPorId(id)).toList();

  //** Adicionar o [livro requisitado] na lista pelo os ids. */
  void addLivroRequisitado(Livro livro) {
    _idsDoslivros.add(livro.id);

    /// Notifica, caso exista um livro que foi requisitado
    notifyListeners();
  }

  void remove(Livro livro) {
    _idsDoslivros.remove(livro.id);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }

  //** Importante para o usar o ChangeNotifierProxyProvider
  //** para atualizar a informacao de um novo livro */
  set livro(LivroModel novoLivro) {
    _listaDeLivros = novoLivro;

    /// Notifica, caso exista um novo livro
    notifyListeners();
  }
}
