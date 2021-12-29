import 'package:flutter/material.dart';

import '../yellow_class.dart';

class CartoesYellowBooks extends StatelessWidget {
  const CartoesYellowBooks(
    this.prateleira1, {
    Key? key,
    required this.index,
  }) : super(key: key);

  final YellowClasse prateleira1;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 103,
          height: 248,
          // espaçamento entre os livros
          margin: EdgeInsets.only(
            right: 10,
            left: index == 0 ? 2.0 : 0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 888,
                  height: 160,
                  margin: const EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(prateleira1.image),
                      fit: BoxFit
                          .cover, // ajuda a ficar do mesmo tamanho (ampliando a imagem)
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    prateleira1.title,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    prateleira1.autor,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
