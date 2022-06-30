import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InformacaoDaApp extends StatelessWidget {
  const InformacaoDaApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 5.0),
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  "A aplicação Biblioteca Escolar de Camarate (BEC) foi desenvolvida como projeto para o trabalho final do curso,"
                  " e associada a uma entidade externa, a Escola Secundária de Camarate."
                  '\n\n'
                  "Uma solução móvel para um sistema de gestão de informação para facilitar na eficiência "
                  "e praticidade de quem gere a requisição de livros em uma biblioteca escolar."
                  '\n\n'
                  "De forma a tornar os processos mais ágeis e eficazes, "
                  "trazendo benefícios aos seus utilizadores, alunos, professores e funcionários da entidade externa."
                  '\n\n'
                  "O sistema foi implementado visando atender as necessidades da biblioteca, "
                  "dando suporte às atividades inerentes ao ambiente da própria biblioteca.",
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 16.0,
                    color: Theme.of(context).textTheme.headline4!.color,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            Center(
              child: Column(
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: Text(
                      'Biblioteca Escolar',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.headline6!.color,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Material(
                    type: MaterialType.transparency,
                    child: Text(
                      'Versão 1.00',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.caption!.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  InkWell(
                    onTap: () => launchUrl(
                      Uri.parse('https://portalesc.wixsite.com/site'),
                    ),
                    child: Image.asset(
                      'assets/logotipo/logo_entidade.jpg',
                      width: 80.0,
                      height: 65.0,
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Material(
                    type: MaterialType.transparency,
                    child: Text(
                      '2021-2022 TFC',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.caption!.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Material(
                    type: MaterialType.transparency,
                    child: Text(
                      'Escola Secundária de Camarate',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        color: Color.fromRGBO(27, 68, 166, 1),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
