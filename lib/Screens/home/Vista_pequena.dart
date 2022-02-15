import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/Screens/lista%20de%20livros/lista_de_livros.dart';
import 'package:camarate_school_library/Screens/lista%20de%20livros/lista_livro_requisitado.dart';
import 'package:camarate_school_library/Utils/cores.dart';
import 'package:flutter/material.dart';

final livros = gerarLivrosAleatorios();

final key = GlobalKey<AnimatedListState>();

class VistaPequena extends StatefulWidget {
  const VistaPequena({Key? key}) : super(key: key);

  @override
  _VistaPequenaState createState() => _VistaPequenaState();
}

class _VistaPequenaState extends State<VistaPequena> {
  final espacamentoVertical = const SizedBox(
    height: 15,
  );

  final espacoTituloELivros = const SizedBox(
    height: 12,
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
            _buildSeccaoTitulo('Livros requisitados'),
            espacoTituloELivros,

            // Livro que foi requisitado
            _buildApresentarLivrosRequisitados(),

            // Titulos
            _buildSeccaoTitulo('Prateleiras'),

            // Espaço
            const SizedBox(
              height: 20,
            ),

            // Titulos
            _buildLSeccaoTitulosClassesDaPrateleira(0),

            // Espaço
            espacamentoVertical,
            SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: 320.0,
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

            // Titulos
            _buildLSeccaoTitulosClassesDaPrateleira(1),
          ],
        ),
      ),
    );
  }

  _buildSeccaoTitulo(String titulo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 7),
              child: titulo == 'Prateleiras'
                  ? Text(
                      titulo,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: darkColor,
                        letterSpacing: -1.5,
                      ),
                    )
                  : Text(
                      titulo,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: darkColor,
                        fontFamily: 'Poppins',
                        letterSpacing: 0.25,
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
                OMeuLivroRequisitado(livros: livros[0]),
              ] else ...[
                const Text(
                  '',
                  textAlign: TextAlign.center,
                ),
              ],
              if (livros[1].isRequisitado == true) ...[
                OMeuLivroRequisitado(livros: livros[1]),
              ] else ...[
                const Text(
                  '',
                  textAlign: TextAlign.center,
                ),
              ],
              if (livros[2].isRequisitado == true) ...[
                OMeuLivroRequisitado(livros: livros[2]),
              ] else ...[
                const Text(
                  '',
                  textAlign: TextAlign.center,
                ),
              ],
              //
              if (livros[3].isRequisitado == true) ...[
                OMeuLivroRequisitado(livros: livros[3]),
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

  _buildLSeccaoTitulosClassesDaPrateleira(int seccao) {
    return Container(
      padding: const EdgeInsets.only(left: 27.0),
      child: Row(
        children: [
          if (seccao == 0) ...[
            // Circulo das classes
            const CircleAvatar(
              backgroundColor: Colors.yellow,
              minRadius: 15,
            ),
            const Padding(
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
          ] else if (seccao == 1) ...[
            // Circulo das classes
            const CircleAvatar(
              backgroundColor: Color(0xffC3A47D),
              minRadius: 15,
            ),
            const Padding(
              // espaço entre o circulo e o título da classe
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Filosofia. Psicologia',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: darkColor,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ] else if (seccao == 2) ...[
            // Circulo das classes
            const CircleAvatar(
              backgroundColor: Color(0xffF59A23),
              minRadius: 15,
            ),
            const Padding(
              // espaço entre o circulo e o título da classe
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Religião. Teologia',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: darkColor,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ] else if (seccao == 3) ...[
            // Circulo das classes
            const CircleAvatar(
              backgroundColor: Color(0xff7B4D12),
              minRadius: 15,
            ),
            const Padding(
              // espaço entre o circulo e o título da classe
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Ciências Sociais',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: darkColor,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ] else if (seccao == 5) ...[
            // Circulo das classes
            const CircleAvatar(
              backgroundColor: Color(0xffD9001B),
              minRadius: 15,
            ),
            const Padding(
              // espaço entre o circulo e o título da classe
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Ciências Exatas. Matemática. Biologia',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: darkColor,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ] else if (seccao == 6) ...[
            // Circulo das classes
            const CircleAvatar(
              backgroundColor: Color(0xffEC808D),
              minRadius: 15,
            ),
            const Padding(
              // espaço entre o circulo e o título da classe
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Ciências Aplicadas. Medicina. Tecnologia',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: darkColor,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ] else if (seccao == 7) ...[
            // Circulo das classes
            const CircleAvatar(
              backgroundColor: Color(0xff1C8EDD),
              minRadius: 15,
            ),
            const Padding(
              // espaço entre o circulo e o título da classe
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Arte. Desporto',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: darkColor,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ] else if (seccao == 8) ...[
            // Circulo das classes
            const CircleAvatar(
              backgroundColor: Color(0xff000000),
              minRadius: 15,
            ),
            const Padding(
              // espaço entre o circulo e o título da classe
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Língua. Linguística. Literatura',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: darkColor,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ] else if (seccao == 9) ...[
            // Circulo das classes
            const CircleAvatar(
              backgroundColor: Color(0xff02790E),
              minRadius: 15,
            ),
            const Padding(
              // espaço entre o circulo e o título da classe
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'História. Geografia. Biografia',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: darkColor,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
