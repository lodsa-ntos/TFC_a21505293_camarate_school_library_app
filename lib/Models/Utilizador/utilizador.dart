class Utilizador {
  final int id;
  String? email;
  String? password;

  // Construtor
  Utilizador({
    required this.id,
    this.email,
    this.password,
  });

  @override
  bool operator ==(Object other) => other is Utilizador && other.id == id;

  @override
  int get hashCode => id;
}
