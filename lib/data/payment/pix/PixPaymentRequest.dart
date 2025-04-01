class PixPaymentRequest {
  final String userId;
  final String nome;
  final String email;
  final String cpf;
  final double valor;

  PixPaymentRequest({
    required this.userId,
    required this.nome,
    required this.email,
    required this.cpf,
    required this.valor,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nome': nome,
      'email': email,
      'cpf': cpf,
      'valor': valor,
    };
  }
}