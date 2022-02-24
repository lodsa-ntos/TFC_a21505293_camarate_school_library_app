import 'package:cached_network_image/cached_network_image.dart';
import 'package:camarate_school_library/Models/modelo_informacao_livro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart'; // DateFormat

class Historico extends StatelessWidget {
  const Historico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child:
                    // Aqui apresento o livro requisitado no ecrã do histórico
                    _FormatoLivroRequisitadoNoHistorico(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Esta classe representa o formato de como quero que os livros requisitados
/// apareçam no ecrã para o utilizador
class _FormatoLivroRequisitadoNoHistorico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Um pequeno tema para o texto(titulo, subTitulo, etc)
    var itemNameStyle = Theme.of(context).textTheme.headline6;

    // Com (context.watch<ModeloInformacaoLivro>();) obtenho o estado atual do
    //ModeloInformacaoLivro e também informa ao Flutter
    // para reconstruir este widget quando o ModeloInformacaoLivro notificar
    // aos utilizadores (em outras palavras, quando houver alterações).
    var requisicao = context.watch<ModeloInformacaoLivro>();

    // Aqui obtenho a data do dia atual
    // E guardo o formato de como quero que a data seja mostrada ao utilizador
    var dataDeHoje = DateTime.now();
    var formato = DateFormat('dd-MM-yyyy');
    String data = formato.format(dataDeHoje);

    return ListView.builder(
      itemCount: requisicao.livros.length,
      itemBuilder: (context, index) => ListTile(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 122.0, // alargar a capa do livro
              margin: const EdgeInsets.only(right: 12.0, top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100.66,
                    height: 150.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(requisicao.livros[index].imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    requisicao.livros[index].titulo, // Titulo do livro
                    style: itemNameStyle,
                  ),
                  const SizedBox(height: 5.0),
                  Text('Data de Entrega: ' + data),
                ],
              ),
            ),
          ],
        ),

        // Aqui permito ao utilizador eliminar o livro requisitado do seu histórico
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            requisicao.remove(requisicao.livros[index]);
          },
        ),
      ),
    );
  }
}
