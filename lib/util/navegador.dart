import 'package:flutter/material.dart';

// Classe para navegar para a página de registo.
class Navegador extends PageRouteBuilder {
  final Widget widget;

  Navegador({required this.widget})
      : super(
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (
            context,
            animation,
            secAnimation,
            Widget child,
          ) {
            animation = CurvedAnimation(
              parent: animation,
              curve: Curves.linearToEaseOut,
            );
            return ScaleTransition(
              alignment: Alignment.center,
              scale: animation,
              child: child,
            );
          },
          pageBuilder: (
            context,
            animation,
            secAnimation,
          ) {
            return widget;
          },
        );
}

// Classe para navegar para a página de recuperação da palavra-passe.
class ReporPass extends PageRouteBuilder {
  final Widget widget;

  ReporPass({required this.widget})
      : super(
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (
            context,
            animation,
            secAnimation,
            Widget child,
          ) {
            animation = CurvedAnimation(
              parent: animation,
              curve: Curves.fastLinearToSlowEaseIn,
            );
            return ScaleTransition(
              alignment: Alignment.center,
              scale: animation,
              child: child,
            );
          },
          pageBuilder: (
            context,
            animation,
            secAnimation,
          ) {
            return widget;
          },
        );
}
