import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      height: 28,
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
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          unselectedLabelStyle: GoogleFonts.catamaran(
                              fontSize: 14, fontWeight: FontWeight.w600),
                          indicator: RoundedRectangleTabIndicator(),
                          tabs: [],
                        ),
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
