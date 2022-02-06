import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<BoxShadow> shadowList = [
  const BoxShadow(color: Colors.grey, blurRadius: 30, offset: Offset(0, 10))
];

List<Map> conteudoDoMenu = [
  {
    'icone': FontAwesomeIcons.book,
    'titulo': 'Consultar requisição',
  },
  {
    'icone': Icons.history,
    'titulo': 'Estatísticas/Histórico',
  },
  {
    'icone': FontAwesomeIcons.userAlt,
    'titulo': 'Perfil',
  },
  {
    'icone': Icons.notifications,
    'titulo': 'Notificação',
  },
];
