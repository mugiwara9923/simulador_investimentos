import '../models/investimento.dart';

class CalculadoraInvestimentos {
  // Calcula o rendimento de um investimento mês a mês.
  static void calcular(Investimento investimento, int meses) {
    // Começamos com o capital inicial informado.
    double saldo = investimento.capitalInicial;

    // Guardamos o saldo inicial na lista de evolução.
    investimento.evolucao = [saldo];

    // Calculamos o total de dinheiro que será investido.
    investimento.totalInvestido =
        investimento.capitalInicial +
        (investimento.aplicacaoMensal * meses);

    // Calculamos o rendimento de cada mês.
    for (int mes = 1; mes <= meses; mes++) {
      // Aplicamos os juros sobre o saldo atual.
      saldo = saldo * (1 + investimento.taxaMensal);

      // Adicionamos a aplicação mensal ao final do mês.
      saldo += investimento.aplicacaoMensal;

      // Guardamos o saldo desse mês.
      investimento.evolucao.add(saldo);
    }

    // Salvamos o montante final.
    investimento.montanteFinal = saldo;

    // Calculamos quanto foi ganho com os juros.
    investimento.rendimentoTotal =
        investimento.montanteFinal - investimento.totalInvestido;
  }
}