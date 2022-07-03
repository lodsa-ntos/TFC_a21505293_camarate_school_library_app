import 'package:camarate_school_library/Models/view_models/conetividade.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SemInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/noInternet/offline.png',
                filterQuality: FilterQuality.high,
                width: 220,
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  "Infelizmente, ocorreu um erro.",
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 2),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  "Algo deu errado.",
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: const Color(0xff4285f4),
                ),

                ///
                child: const Text(
                  'Tentar novamente',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Provider.of<Conectividade>(context, listen: false)
                      .iniciarConectividade();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
