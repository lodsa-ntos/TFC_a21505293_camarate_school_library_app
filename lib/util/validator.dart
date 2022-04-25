class Validator {

  static String? validarEmail({required String? email}) {
    if (email == null) {
      return "Nenhum e-mail encontrado";
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return "O campo do e-mail não pode ser vazio";
    } else if (!emailRegExp.hasMatch(email)) {
      return "Por favor, introduza um email válido";
    }

    return null;
  }

  static String? validarPassword({required String? password}) {
    if (password == null) {
     return "A tua palavra-passe estava incorreta. Verifica-a novamente.";
    }

    if (password.isEmpty) {
      return "O campo da palavra-passe não pode ser vazio";
    } else if (password.length < 8) {
      return "A palavra-passe deve conter mais de 8 caracteres";
    }

    return null;
  }
}
