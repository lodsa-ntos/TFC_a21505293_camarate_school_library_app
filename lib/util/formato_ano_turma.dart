import 'package:flutter/services.dart';

class FormatoAnoTurma extends TextInputFormatter {
  final String tipoFormato;
  final String separador;

  FormatoAnoTurma({
    required this.tipoFormato,
    required this.separador,
  }) {
    // ignore: unnecessary_null_comparison
    assert(tipoFormato != null);
    // ignore: unnecessary_null_comparison
    assert(separador != null);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue primeiroValor, TextEditingValue novoValor) {
    if (novoValor.text.length > 0) {
      if (novoValor.text.length > primeiroValor.text.length) {
        if (novoValor.text.length > tipoFormato.length) return primeiroValor;
        if (novoValor.text.length < tipoFormato.length &&
            tipoFormato[novoValor.text.length - 1] == separador) {
          return TextEditingValue(
            text:
                '${primeiroValor.text}$separador${novoValor.text.substring(novoValor.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: novoValor.selection.end + 1,
            ),
          );
        }
      }
    }

    return novoValor;
  }
}
