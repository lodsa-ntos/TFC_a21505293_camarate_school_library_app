import 'package:camarate_school_library/Models/livro.dart';
import 'package:flutter/material.dart';

class HomeRequisitarProvider extends ChangeNotifier {
  //** Variável privada [livro], para chamar e guardar o livro por id. */
  late GerarLivro _livro;

  //** Lista privada para armazenar os ids de cada livro */.
  final List<int> _idsDoslivros = [];

  //** Com esta variável [_livro] obtenho os livros por ids */
  GerarLivro get livro => _livro;

  //** Lista para guardar os livros por id na lista de _idsDoslivros no formato de uma lista. */
  List<Livro> get livros =>
      _idsDoslivros.map((id) => _livro.getPorId(id)).toList();

  //** Adicionar o [livro requisitado] na lista com os seus ids. */
  void addLivroRequisitado(Livro livro) {
    _idsDoslivros.add(livro.id);

    /// Notifica, caso exista um livro que foi requisitado
    notifyListeners();
  }

  //** Importante para o usar o ChangeNotifierProxyProvider
  //** para atualizar a informacao de um novo livro */
  set livro(GerarLivro novoLivro) {
    _livro = novoLivro;

    /// Notifica, caso exista um novo livro
    notifyListeners();
  }
}
