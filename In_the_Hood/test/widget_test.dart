import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:in_the_hood/main.dart';

void main() {
  testWidgets('Home shows featured listings and navigation buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('In the Hood'), findsOneWidget);
    expect(find.text('Featured near you'), findsOneWidget);
    expect(find.text('Vintage Bike'), findsOneWidget);

    await tester.tap(find.widgetWithIcon(ElevatedButton, Icons.map));
    await tester.pumpAndSettle();
    expect(find.text('Neighborhood Map'), findsOneWidget);
  });
}
