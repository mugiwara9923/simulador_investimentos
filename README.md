# Simulador de Investimentos Personalizado

## Sobre o projeto

O Simulador de Investimentos Personalizado é um aplicativo desenvolvido com Flutter e Dart que permite comparar dois investimentos ao longo de um período definido pelo usuário.

O objetivo é ajudar o usuário a visualizar a evolução do dinheiro investido e comparar os rendimentos obtidos em cada opção.

## Funcionalidades

- Cadastro de dois investimentos para comparação.
- Definição do nome de cada investimento.
- Informações sobre o capital inicial.
- Definição do valor das aplicações mensais.
- Configuração da taxa de juros mensal.
- Escolha do período da simulação em meses.
- Cálculo dos rendimentos utilizando juros compostos.
- Exibição do montante final de cada investimento.
- Apresentação do total investido e do rendimento obtido.
- Identificação do investimento com maior montante final.
- Comparação da evolução dos saldos mês a mês.
- Possibilidade de realizar uma nova simulação.

## Tecnologias utilizadas

- Flutter
- Dart
- Material Design

## Organização do projeto

```text
lib/
├── main.dart
├── models/
│   └── investimento.dart
├── pages/
│   └── tela_resultados.dart
└── services/
    └── calculadora_investimentos.dart