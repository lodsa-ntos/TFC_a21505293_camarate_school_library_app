import 'package:camarate_school_library/Home/Prateleiras/Lista_amarela/Dados/dados_lista_amarela.dart';
import 'package:flutter/material.dart';

class PaginaDetalhesLivro extends StatelessWidget {
  const PaginaDetalhesLivro({
    Key? key,
    required this.livros,
  }) : super(key: key);

  final DadosListaAmarela livros;

  @override
  Widget build(BuildContext context) {
    Size tamanho = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 48, left: 32),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 42,
                    width: 42,
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  livros.imagem,
                  fit: BoxFit.fitWidth,
                  width: 175.0,
                  height: 267.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
