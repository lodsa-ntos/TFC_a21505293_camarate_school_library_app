import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Procedimentos extends StatelessWidget {
  const Procedimentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/voltar.svg"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Conselhos e procedimentos',
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headline6!.color,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 10.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "• ",
                  style: TextStyle(fontSize: 25),
                ),
                Expanded(
                  child: Text(
                    'Entra na biblioteca com calma e correção, respeitando as regras da boa educação.',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "• ",
                  style: TextStyle(fontSize: 25),
                ),
                Expanded(
                  child: Text(
                    'Desinfeta as mãos e dirige-te ao balcão de atendimento para registares no TABLET  a tua presença, assim como a atividade que vais fazer.',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "• ",
                  style: TextStyle(fontSize: 25),
                ),
                Expanded(
                  child: Text(
                    'Deves ser responsável e cuidar dos teus objetos pessoais.',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "• ",
                  style: TextStyle(fontSize: 25),
                ),
                Expanded(
                  child: Text(
                    'Não deves fazer barulho e evitar pertubar o trabalho de outros utilizadores.',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "• ",
                  style: TextStyle(fontSize: 25),
                ),
                Expanded(
                  child: Text(
                    'Não podes comer, beber ou mastigar pastilha elástica.',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "• ",
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                  child: Text(
                    'Deves deixar o espaço limpo e arrumado.',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "• ",
                  style: TextStyle(fontSize: 25),
                ),
                Expanded(
                  child: Text(
                    'Não danifiques os livros, outros materiais e equipamentos.',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "• ",
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                  child: Text(
                    'Preserva o espaço e os recursos.',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "• ",
                  style: TextStyle(fontSize: 25),
                ),
                Expanded(
                  child: Text(
                    'Quando terminares a tua atividade, deves deixar o espaço limpo e arrumado.',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'from',
                  style: TextStyle(
                    fontFamily: 'Carmen',
                    color: Colors.grey.shade700,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 5.5),
                Image.asset('assets/logotipo/logo_entidade.jpg', width: 25),
                SizedBox(height: 5.5),
                Text(
                  'Escola Secundária de Camarate',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Carmen',
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4285F4),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
