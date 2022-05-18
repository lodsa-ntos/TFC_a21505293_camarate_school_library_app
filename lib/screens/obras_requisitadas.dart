import 'package:flutter/material.dart';

class ObrasRequisitadas extends StatelessWidget {
  const ObrasRequisitadas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            children: const [
              Text(
                'Obras requisitadas',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
