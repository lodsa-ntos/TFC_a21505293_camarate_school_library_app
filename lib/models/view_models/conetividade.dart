import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Conectividade with ChangeNotifier {
  final Connectivity _conectar = new Connectivity();

  bool? _isOnline;
  bool? get isOnline => _isOnline;

  verificarLigacao() async {
    await iniciarConectividade();
    _conectar.onConnectivityChanged.listen((
      ConnectivityResult resultado,
    ) async {
      if (resultado == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        await _atualizarEstadoConexao().then((bool? isConnected) {
          _isOnline = isConnected;
          notifyListeners();
        });
      }
    });
  }

  Future<void> iniciarConectividade() async {
    try {
      var estado = await _conectar.checkConnectivity();

      if (estado == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        _isOnline = true;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      print("Error: " + e.toString());
    }
  }

  Future<bool?> _atualizarEstadoConexao() async {
    bool? isConectado;
    try {
      final List<InternetAddress> resultado =
          await InternetAddress.lookup('google.com');
      if (resultado.isNotEmpty && resultado[0].rawAddress.isNotEmpty) {
        isConectado = true;
      }
    } on SocketException catch (_) {
      isConectado = false;
      //return false;
    }
    return isConectado;
  }
}
