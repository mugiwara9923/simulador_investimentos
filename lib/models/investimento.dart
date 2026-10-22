class Investimento {
  String nome;
  double capitalInicial;
  double aplicacaoMensal;
  double taxaMensal;

  // Guarda a evolução do saldo ao longo dos meses.
  List<double> evolucao = [];

  // Guarda o montante final calculado.
  double montanteFinal = 0;

  // Guarda o total de dinheiro aplicado.
  double totalInvestido = 0;

  // Guarda o rendimento obtido.
  double rendimentoTotal = 0;

  Investimento({
    required this.nome,
    required this.capitalInicial,
    required this.aplicacaoMensal,
    required this.taxaMensal,
  });
}