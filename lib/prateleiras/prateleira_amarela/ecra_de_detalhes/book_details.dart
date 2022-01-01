// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---> BOTÃO REQUISITAR <---
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
        height: 49,
        color: Colors.transparent,
        child: FlatButton(
          color: const Color.fromRGBO(18, 157, 158, 1),
          onPressed: () {},
          child: Text(
            'Requisitar',
            style: GoogleFonts.catamaran(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      // ---> TERMINA EDIÇÃO BOTÃO REQUISITAR <---

      body: SafeArea(
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.grey,
                // Pinta metade da cor cinzenta
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                flexibleSpace: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  color: const Color.fromRGBO(18, 157, 158, 1),
                  child: Stack(
                    children: <Widget>[
                      const Positioned(
                        left: 25,
                        top: 35,
                        child: SizedBox(
                          width: 32,
                          height: 32,

                          /// outra ideia para depois ....
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 62),
                          width: 225,
                          height: 272,
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/sem_imagem.jpg'),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.only(top: 24, left: 25),
                      child: Text(
                        'Lorem ipsum',
                        style: GoogleFonts.catamaran(
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7, left: 25),
                      child: Text(
                        'Lorem ipsum',
                        style: GoogleFonts.catamaran(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      margin: const EdgeInsets.only(top: 23, bottom: 36),
                      padding: const EdgeInsets.only(left: 25),
                      child: DefaultTabController(
                        length: 1,
                        child: TabBar(
                          labelPadding: const EdgeInsets.all(0),
                          indicatorPadding: const EdgeInsets.all(0),
                          isScrollable: true,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          labelStyle: GoogleFonts.catamaran(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          unselectedLabelStyle: GoogleFonts.catamaran(
                              fontSize: 14, fontWeight: FontWeight.w600),
                          tabs: [
                            Tab(
                              child: Container(
                                margin: const EdgeInsets.only(right: 23),
                                child: const Text('Descrição'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          letterSpacing: 1.5,
                          height: 2,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
