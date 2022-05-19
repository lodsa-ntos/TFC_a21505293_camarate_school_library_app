import 'package:camarate_school_library/models/livro_model.dart';
import 'package:camarate_school_library/models/utilizadores_model.dart';

class ObrasRequisitadas {
  int? numDeVezes;
  Pessoa? requisitante;
  Livro? titulo;
  Livro? dataRequisicao;
  Livro? capaPath;

  ObrasRequisitadas({
    this.requisitante,
    this.titulo,
    this.capaPath,
    this.numDeVezes,
    this.dataRequisicao,
  });
}
