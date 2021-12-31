import 'package:flutter/material.dart';

class DetalhesDosLivrosShelfYellow extends StatelessWidget {
  const DetalhesDosLivrosShelfYellow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Estrutura do fundo simples
          Positioned.fill(
            child: Column(
              children: [
                // Area blue grey - parte de cima
                Expanded(
                  child: Container(
                    color: Colors.blueGrey[300],
                  ),
                ),

                // Area branca - parte de baixo
                Expanded(
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Icone voltar para trás
          Container(
            // alinhamento do icon
            margin: const EdgeInsets.only(top: 25, left: 12),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          ),

          // Foto do livro
          Container(
            margin: const EdgeInsets.only(top: 75),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset('assets/images/sem_imagem.jpg',
                  width: 300, height: 300),
            ),
          ),
        ],
      ),
    );
  }
}
