import 'package:camarate_school_library/View_models/home_requisitar_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//** Esta classe está aqui apenas para espelhar o que aparece no ecrã do histórico */
//** Esta classe representa o formato de como quero que os livros requisitados */
//** apareçam no ecrã para o utilizador */

class FormatoLivroRequisitadoParaUtilizador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //** Consumer dos livros que vão ser requisitados */
    return Consumer<HomeRequisitarProvider>(
      //** (context, requisicao, child) --> variaveis */
      builder: (context, requisicao, child) => ListView.builder(
        //** scroll na horizontal */
        scrollDirection: Axis.horizontal,
        //** tamanho máximo da lista para a requisicao */
        itemCount: requisicao.livros.length,
        itemBuilder: (context, index) => Row(
          children: [
            Container(
              width: 111.0,
              margin: const EdgeInsets.only(right: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 121.66,
                    height: 165.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        //** Capa */
                        image: NetworkImage(requisicao.livros[index].imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),

                  //** Titulo */
                  Text(
                    requisicao.livros[index].titulo,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                    ),
                  ),

                  const SizedBox(height: 5.0),

                  //** Data: */
                  Text(
                    'Data da requisição: ' +
                        requisicao.livros[index].getDataAtual(),
                    style: GoogleFonts.catamaran(
                      textStyle: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
