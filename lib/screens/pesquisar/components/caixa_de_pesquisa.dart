import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class _CaixaDePesquisaState extends State<CaixaDePesquisa> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LivroRequisitadoModel>(
      builder: (BuildContext context, LivroRequisitadoModel detalheModel,
          Widget? child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 7),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color.fromARGB(255, 228, 228, 228),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 3,
                  ),
                  child: Row(
                    children: [
                      //* Lupa
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/pesquisa.svg',
                        ),
                        onPressed: () {},
                      ),

                      //* Caixa de texto
                      Expanded(
                        child: TextField(
                          controller: widget.controlador,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Pesquise o seu livro...',
                            hintStyle: TextStyle(fontSize: 15),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Gilroy',
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                          ),
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CaixaDePesquisa extends StatefulWidget {
  const CaixaDePesquisa({
    required this.controlador,
    Key? key,
  }) : super(key: key);

  final TextEditingController controlador;

  @override
  State<CaixaDePesquisa> createState() => _CaixaDePesquisaState();
}
