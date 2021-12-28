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
    return Container(
      width: 103,
      height: 218,
      margin: EdgeInsets.only(
        right: 12,
        left: index == 0 ? 30.0 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(prateleira1.image),
          ),
          Text(
            prateleira1.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
          ),
          Text(
            prateleira1.autor,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
