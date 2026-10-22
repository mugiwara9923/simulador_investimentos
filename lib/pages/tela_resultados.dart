import 'package:flutter/material.dart';

import '../models/investimento.dart';

class TelaResultados extends StatelessWidget {
  final Investimento investimentoA;
  final Investimento investimentoB;
  final int meses;

  const TelaResultados({
    super.key,
    required this.investimentoA,
    required this.investimentoB,
    required this.meses,
  });

  // Formata os valores como moeda brasileira.
  String formatarMoeda(double valor) {
    final valorFormatado = valor.toStringAsFixed(2);
    final partes = valorFormatado.split('.');
    String parteInteira = partes[0];

    parteInteira = parteInteira.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (match) => '${match[1]}.',
    );

    return 'R\$ $parteInteira,${partes[1]}';
  }

  // Apresenta um resumo de um investimento.
  Widget criarResumo(Investimento investimento, Color cor) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                investimento.nome,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: cor,
                ),
              ),
              const SizedBox(height: 12),
              const Text('Montante final'),
              Text(
                formatarMoeda(investimento.montanteFinal),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              const Text('Total investido'),
              Text(formatarMoeda(investimento.totalInvestido)),
              const SizedBox(height: 12),
              const Text('Rendimento'),
              Text(
                formatarMoeda(investimento.rendimentoTotal),
                style: TextStyle(
                  color: cor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final melhorInvestimento =
        investimentoA.montanteFinal >= investimentoB.montanteFinal
            ? investimentoA
            : investimentoB;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparação de investimentos'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Resultado da simulação',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Período: $meses meses',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Compara os resultados finais lado a lado.
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                criarResumo(investimentoA, Colors.green),
                criarResumo(investimentoB, Colors.blue),
              ],
            ),

            const SizedBox(height: 16),

            Card(
              color: Colors.green.withValues(alpha: 0.10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Maior montante final',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      melhorInvestimento.nome,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      formatarMoeda(
                        melhorInvestimento.montanteFinal,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Evolução mensal',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Lista comparativa dos saldos mês a mês.
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: meses + 1,
              itemBuilder: (context, indice) {
                final saldoA = investimentoA.evolucao[indice];
                final saldoB = investimentoB.evolucao[indice];

                final titulo =
                    indice == 0 ? 'Início' : 'Mês $indice';

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titulo,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${investimentoA.nome}: '
                          '${formatarMoeda(saldoA)}',
                          style: const TextStyle(color: Colors.green),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${investimentoB.nome}: '
                          '${formatarMoeda(saldoB)}',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Retorna à tela anterior para uma nova simulação.
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Nova simulação'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}