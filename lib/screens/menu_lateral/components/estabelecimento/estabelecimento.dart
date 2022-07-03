import 'package:camarate_school_library/Models/view_models/conetividade.dart';
import 'package:camarate_school_library/Screens/sem_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Estabelecimento extends StatefulWidget {
  const Estabelecimento({Key? key}) : super(key: key);

  @override
  State<Estabelecimento> createState() => _EstabelecimentoState();
}

class _EstabelecimentoState extends State<Estabelecimento> {
  @override
  void initState() {
    super.initState();
    Provider.of<Conectividade>(context, listen: false).verificarLigacao();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Conectividade>(
      builder: (context, utilizador, child) {
        if (utilizador.isOnline != null) {
          return utilizador.isOnline ?? false
              ? Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    leading: IconButton(
                      icon: SvgPicture.asset("assets/icons/voltar.svg"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(
                      'Estabelecimento',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.headline6!.color,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, top: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Horário',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .color,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Abertura -  2º a 6º f - 9h55',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .color,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Encerramento -  2º e 6º f - 16h00',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .color,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 15),
                            Text(
                              '                               3º e 5º f - 17h30',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .color,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 70),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Morada:',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .color,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'Rua Heróis de Mucaba,',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .color,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Bº de Angola',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .color,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '2680-048 Camarate',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .color,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Telefone: 219479493',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .color,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'bibliotecaescamarate@gmail.com',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .color,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40),
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () => launchUrl(
                                  Uri.parse(
                                      'https://portalesc.wixsite.com/site'),
                                ),
                                child: Column(
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
                                    Image.asset(
                                        'assets/logotipo/logo_entidade.png',
                                        width: 25),
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : SemInternet();
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
