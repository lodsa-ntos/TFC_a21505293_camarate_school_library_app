class Validator {
  static String? validarEmail({required String? email}) {
    if (email == null) {
      return "Nenhum e-mail encontrado";
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.trim().isEmpty) {
      return "Este campo é obrigatório";
    } else if (!emailRegExp.hasMatch(email.trim())) {
      return "Introduza um email válido";
    }

    return null;
  }

  static String? validarPassword({required String? password}) {
    if (password == null) {
      return "A tua palavra-passe estava incorreta. Verifica-a novamente.";
    }

    if (password.trim().isEmpty) {
      return "Este campo é obrigatório";
    } else if (password.trim().length < 8) {
      return "A palavra-passe deve conter mais de 8 caracteres";
    }

    return null;
  }

  static String? validarNumeroCartao({required String? numCartao}) {
    if (numCartao == null) {
      return "O número do cartão estava incorreta. Verifica-a novamente.";
    }

    RegExp _validNumero = RegExp("[0-9]+");

    if (numCartao.trim().isEmpty) {
      return "Este campo é obrigatório";
    } else if (!_validNumero.hasMatch(numCartao.trim())) {
      return "Introduza um número de cartão válido";
    }

    return null;
  }

  static String? validarNomeCompleto({required String? nome}) {
    if (nome == null) {
      return "O nome completo estava incorreta. Verifica novamente.";
    }

    RegExp _validNomeCompleto = RegExp(r'^[a-z A-Z,.\-]+$');

    if (nome.trim().isEmpty) {
      return "Este campo é obrigatório";
    } else if (!_validNomeCompleto.hasMatch(nome.trim())) {
      return "Introduza um nome válido. Apenas o primeiro nome e so último";
    }

    return null;
  }

  static String? validarUsername({required String? username}) {
    if (username == null) {
      return "O nome de utilizador estava incorreta. Verifica novamente.";
    }

    if (username.trim().isEmpty) {
      return "Este campo é obrigatório";
    } else if (username.trim().length < 4) {
      return "O nome de utilizador deve ter pelo menos 4 caracteres";
    }

    return null;
  }

  static String? validarPasswordRegisto({required String? password}) {
    if (password == null) {
      return "A tua palavra-passe estava incorreta. Verifica-a novamente.";
    }

    RegExp passRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (password.trim().isEmpty) {
      return "Este campo é obrigatório";
    } else if (password.trim().length < 8) {
      return "A palavra-passe deve conter mais de 8 caracteres";
    } else if (!passRegExp.hasMatch(password.trim())) {
      return "A palavra-passe deve conter pelo menos uma letra maiúscula, uma minúscula, um número e caractere especial";
    }

    return null;
  }

  static String? validarAno({required String? ano}) {
    if (ano == null) {
      return "O ano estava incorreto. Verifica novamente.";
    }

    RegExp _validNumero = RegExp(r'[0-9]');

    if (ano.trim().isEmpty) {
      return "Este campo é obrigatório";
    } else if (!_validNumero.hasMatch(ano.trim())) {
      return "";
    }

    return null;
  }

  static String? validarTurma({required String? turma}) {
    if (turma == null) {
      return "A turma estava incorreta. Verifica novamente.";
    }

    RegExp _validNumero = RegExp(r'[a-z A-Z]');

    if (turma.trim().isEmpty) {
      return "Este campo é obrigatório";
    } else if (!_validNumero.hasMatch(turma.trim())) {
      return "Introduzaa tua turma.";
    }

    return null;
  }
}
