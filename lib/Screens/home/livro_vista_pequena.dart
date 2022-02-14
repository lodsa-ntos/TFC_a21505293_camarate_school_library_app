import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/Screens/lista%20de%20livros/lista_de_livros.dart';
import 'package:camarate_school_library/Screens/lista%20de%20livros/lista_livro_requisitado.dart';
import 'package:camarate_school_library/Utils/cores.dart';
import 'package:flutter/material.dart';

final livros = gerarLivrosAleatorios();

final key = GlobalKey<AnimatedListState>();

class LivroVistaPequena extends StatefulWidget {
  const LivroVistaPequena({Key? key}) : super(key: key);

  @override
  _LivroVistaPequenaState createState() => _LivroVistaPequenaState();
}

class _LivroVistaPequenaState extends State<LivroVistaPequena> {
  final espacamentoVertical = const SizedBox(
    height: 15,
  );

  final areaVazia = CustomPaint(
    child: Container(
      margin: const EdgeInsets.only(
        left: 26.0,
        right: 26.0,
      ),
      color: Colors.white,
      child: const Center(
        child: Text('<vazio>'),
      ),
    ),
  );

  final tituloSeccaoAmarela = Container(
    padding: const EdgeInsets.only(left: 27.0),
    child: Row(
      children: const [
        // Circulo das classes
        CircleAvatar(
          backgroundColor: Colors.yellow,
          minRadius: 15,
        ),
        Padding(
          // espaço entre o circulo e o título da classe
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'Generabilidade.Dicionários.\nEnciclopédias.Informática',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: darkColor,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Espaço
            espacamentoVertical,
            _buildSeccaoTitulo('Livros Requisitados'),
            _buildLinhaADividir(),

            const SizedBox(
              height: 20,
            ),

            // Área que vai apresentar livros requisitados
            _buildApresentarLivrosRequisitados(),

            // Titulos
            _buildSeccaoTitulo('Prateleiras'),

            // Espaço
            const SizedBox(
              height: 20,
            ),

            tituloSeccaoAmarela,

            // Espaço
            espacamentoVertical,
            SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: 350.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: ListView.builder(
                    // carregar até ao último indice
                    itemCount: livros.length,
                    scrollDirection: Axis.horizontal,
                    // comportamento para que a ListView só ocupe o espaço de que necessita
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        ListaDeLivros(livros: livros[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildLinhaADividir() {
    return Divider(
      //thickness: 4,
      indent: 27,
      endIndent: 29,
      color: Theme.of(context).textTheme.caption!.color,
    );
  }

  _buildSeccaoTitulo(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 7),
              width: MediaQuery.of(context).size.width / 2,
              child: title == 'Prateleiras'
                  ? Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: darkColor,
                      ),
                    )
                  : Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: darkColor,
                        fontFamily: 'Poppins',
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  _buildApresentarLivrosRequisitados() {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: 285.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // Por enquanto assim...
              if (livros[0].isRequisitado == true) ...[
                ListaLivroRequisitado(livros: livros[0]),
              ] else ...[
                const Text(
                  '',
                  textAlign: TextAlign.center,
                ),
              ],
              if (livros[1].isRequisitado == true) ...[
                ListaLivroRequisitado(livros: livros[1]),
              ] else ...[
                const Text(
                  '',
                  textAlign: TextAlign.center,
                ),
              ],
              if (livros[2].isRequisitado == true) ...[
                ListaLivroRequisitado(livros: livros[2]),
              ] else ...[
                const Text(
                  '',
                  textAlign: TextAlign.center,
                ),
              ],
              //
              if (livros[3].isRequisitado == true) ...[
                ListaLivroRequisitado(livros: livros[3]),
              ] else ...[
                const Text(
                  '',
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
