import 'package:flutter/material.dart';

import 'models/investimento.dart';
import 'services/calculadora_investimentos.dart';
import 'pages/tela_resultados.dart';

void main() {
  runApp(const MeuAplicativo());
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simulador de Investimentos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      home: const TelaSimulacao(),
    );
  }
}

class TelaSimulacao extends StatefulWidget {
  const TelaSimulacao({super.key});

  @override
  State<TelaSimulacao> createState() => _TelaSimulacaoState();
}

class _TelaSimulacaoState extends State<TelaSimulacao> {
  // Controladores dos campos do Investimento A.
  final TextEditingController nomeAController =
      TextEditingController(text: 'Investimento A');

  final TextEditingController capitalAController =
      TextEditingController();

  final TextEditingController aplicacaoAController =
      TextEditingController();

  final TextEditingController taxaAController =
      TextEditingController();

  // Controladores dos campos do Investimento B.
  final TextEditingController nomeBController =
      TextEditingController(text: 'Investimento B');

  final TextEditingController capitalBController =
      TextEditingController();

  final TextEditingController aplicacaoBController =
      TextEditingController();

  final TextEditingController taxaBController =
      TextEditingController();

  // Controlador do período compartilhado.
  final TextEditingController periodoController =
      TextEditingController(text: '12');

  @override
  void dispose() {
    nomeAController.dispose();
    capitalAController.dispose();
    aplicacaoAController.dispose();
    taxaAController.dispose();

    nomeBController.dispose();
    capitalBController.dispose();
    aplicacaoBController.dispose();
    taxaBController.dispose();

    periodoController.dispose();

    super.dispose();
  }

  // Cria um campo de texto reutilizável.
  Widget criarCampo({
    required String titulo,
    required TextEditingController controller,
    bool numerico = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: numerico
            ? const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              )
            : TextInputType.text,
        decoration: InputDecoration(
          labelText: titulo,
          border: const OutlineInputBorder(),
          prefixIcon: numerico
              ? const Icon(Icons.attach_money)
              : null,
        ),
      ),
    );
  }

  // Converte os números digitados para double.
  double? converterNumero(String texto) {
    // Aceita vírgula ou ponto como separador decimal.
    return double.tryParse(texto.trim().replaceAll(',', '.'));
  }

  // Valida os campos, calcula os resultados e abre a outra tela.
  void compararInvestimentos() {
    final capitalA = converterNumero(capitalAController.text);
    final aplicacaoA = converterNumero(aplicacaoAController.text);
    final taxaA = converterNumero(taxaAController.text);

    final capitalB = converterNumero(capitalBController.text);
    final aplicacaoB = converterNumero(aplicacaoBController.text);
    final taxaB = converterNumero(taxaBController.text);

    final meses = int.tryParse(periodoController.text.trim());

    final nomeA = nomeAController.text.trim();
    final nomeB = nomeBController.text.trim();

    // Verifica se todos os campos foram preenchidos corretamente.
    if (nomeA.isEmpty ||
        nomeB.isEmpty ||
        capitalA == null ||
        aplicacaoA == null ||
        taxaA == null ||
        capitalB == null ||
        aplicacaoB == null ||
        taxaB == null ||
        meses == null) {
      mostrarMensagem('Preencha todos os campos com valores válidos.');
      return;
    }

    // Impede valores negativos e período igual a zero.
    if (capitalA < 0 ||
        aplicacaoA < 0 ||
        taxaA < 0 ||
        capitalB < 0 ||
        aplicacaoB < 0 ||
        taxaB < 0 ||
        meses <= 0) {
      mostrarMensagem(
        'Os valores não podem ser negativos e o período deve ser maior que zero.',
      );
      return;
    }

    // Cria o primeiro investimento.
    final investimentoA = Investimento(
      nome: nomeA,
      capitalInicial: capitalA,
      aplicacaoMensal: aplicacaoA,
      taxaMensal: taxaA / 100,
    );

    // Cria o segundo investimento.
    final investimentoB = Investimento(
      nome: nomeB,
      capitalInicial: capitalB,
      aplicacaoMensal: aplicacaoB,
      taxaMensal: taxaB / 100,
    );

    // Calcula os rendimentos dos dois investimentos.
    CalculadoraInvestimentos.calcular(investimentoA, meses);
    CalculadoraInvestimentos.calcular(investimentoB, meses);

    // Abre a tela de resultados e envia os dados calculados.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaResultados(
          investimentoA: investimentoA,
          investimentoB: investimentoB,
          meses: meses,
        ),
      ),
    );
  }

  // Exibe mensagens para orientar o usuário.
  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulador de Investimentos'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.trending_up,
              size: 65,
              color: Colors.green,
            ),

            const SizedBox(height: 10),

            const Text(
              'Compare seus investimentos',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            // Dados do primeiro investimento.
            const Text(
              'Investimento A',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 12),

            criarCampo(
              titulo: 'Nome do investimento',
              controller: nomeAController,
            ),

            criarCampo(
              titulo: 'Capital inicial (R\$)',
              controller: capitalAController,
              numerico: true,
            ),

            criarCampo(
              titulo: 'Aplicação mensal (R\$)',
              controller: aplicacaoAController,
              numerico: true,
            ),

            criarCampo(
              titulo: 'Taxa de juros mensal (%)',
              controller: taxaAController,
              numerico: true,
            ),

            const Divider(height: 35),

            // Dados do segundo investimento.
            const Text(
              'Investimento B',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 12),

            criarCampo(
              titulo: 'Nome do investimento',
              controller: nomeBController,
            ),

            criarCampo(
              titulo: 'Capital inicial (R\$)',
              controller: capitalBController,
              numerico: true,
            ),

            criarCampo(
              titulo: 'Aplicação mensal (R\$)',
              controller: aplicacaoBController,
              numerico: true,
            ),

            criarCampo(
              titulo: 'Taxa de juros mensal (%)',
              controller: taxaBController,
              numerico: true,
            ),

            const Divider(height: 35),

            const Text(
              'Período da simulação',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            criarCampo(
              titulo: 'Quantidade de meses',
              controller: periodoController,
              numerico: true,
            ),

            const SizedBox(height: 10),

            // Executa a comparação dos investimentos.
            ElevatedButton.icon(
              onPressed: compararInvestimentos,
              icon: const Icon(Icons.calculate),
              label: const Text('Comparar investimentos'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}