import 'package:camarate_school_library/Models/view_models/conetividade.dart';
import 'package:camarate_school_library/Screens/sem_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class _CorpoDocenteState extends State<CorpoDocente> {
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
                  appBar: AppBar(
                    leading: IconButton(
                      icon: SvgPicture.asset("assets/icons/voltar.svg"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(
                      'Corpo docente',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.headline6!.color,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 3.0, right: 5.0),
                          child: SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                const SizedBox(height: 15),
                                DataTable(
                                  dataRowHeight: 65,
                                  headingRowHeight: 45,
                                  horizontalMargin: 16,
                                  columnSpacing: 15,
                                  showBottomBorder: true,

                                  headingRowColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.white),

                                  //? Colunas

                                  columns: const [
                                    DataColumn(
                                      label: Text(
                                        'Docente',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Responsabilidade',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Contacto',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ],

                                  //? Linhas

                                  rows: <DataRow>[
                                    DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            'Ana Paula Lino',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Color(0xff4285f4),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            'Professora bibliotecária',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            'analino@escamarate.pt',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            'Jorge Parente',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Color(0xff4285f4),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            'Professor colaborador',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            'Ana Paula Batalha',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Color(0xff4285f4),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            'Professora colaboradora',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            'Hugo Maia',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Color(0xff4285f4),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            'Professor colaborador',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            'Ana Bela Lopes',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Color(0xff4285f4),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            'Professora colaboradora',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            'Margarida Coimbra',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Color(0xff4285f4),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            'Professora colaboradora',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            'Helena Marques',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Color(0xff4285f4),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            'Professora colaboradora',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            'Armando Silva',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Color(0xff4285f4),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            'Professor colaborador',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            'Graça Costa',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Color(0xff4285f4),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            'Professora colaboradora',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            'Carla Clemente',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Color(0xff4285f4),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            'Professora colaboradora',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

class CorpoDocente extends StatefulWidget {
  const CorpoDocente({Key? key}) : super(key: key);

  @override
  State<CorpoDocente> createState() => _CorpoDocenteState();
}
