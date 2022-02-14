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
    height: 14,
  );

  final tituloLivrosRequisitados = Container(
    padding: const EdgeInsets.symmetric(horizontal: 26.0),
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.0),
      child: Text(
        'Livros Requisitados',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: darkColor,
          fontFamily: 'Poppins',
        ),
      ),
    ),
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

  final tituloPrateleiras = Container(
    padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 30),
    child: const Text(
      'Prateleiras',
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 28,
        color: darkColor,
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
                fontSize: 16,
                color: darkColor,
                fontFamily: 'Poppins'),
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
            tituloLivrosRequisitados,

            // Espaço
            espacamentoVertical,

            // Área para livros requisitados .--> por enquanto ainda vazia
            SingleChildScrollView(
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
            ),
            //const Divider(),
            // Titulos
            tituloPrateleiras,
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
}
