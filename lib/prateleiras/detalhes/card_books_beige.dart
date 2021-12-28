import 'package:flutter/material.dart';

import '../beige_class.dart';
import '../yellow_class.dart';

class CartoesBeigeBooks extends StatelessWidget {
  const CartoesBeigeBooks(
    this.prateleira2, {
    Key? key,
    required this.index,
  }) : super(key: key);

  final BeigeClasse prateleira2;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 103,
      height: 218,
      margin: EdgeInsets.only(
        right: 12,
        left: index == 0 ? 30.0 : 0,
        bottom: 190,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(prateleira2.image),
          ),
          Text(
            prateleira2.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
          ),
          Text(
            prateleira2.autor,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
