import 'package:flutter_test/flutter_test.dart';

import 'package:simulador_investimentos/main.dart';

void main() {
  testWidgets('Aplicativo inicia corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(const MeuAplicativo());

    expect(find.text('Simulador de Investimentos'), findsOneWidget);
    expect(find.text('Compare seus investimentos'), findsOneWidget);
  });
}