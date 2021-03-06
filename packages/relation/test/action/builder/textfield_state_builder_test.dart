import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pedantic/pedantic.dart';
import 'package:relation/relation.dart';

void main() {
  testWidgets(
    'TextfieldStreamBuilder content test',
    (WidgetTester tester) async {
      final testData = TextFieldStreamedState('test');
      final textFieldStateBuilder = TextFieldStateBuilder(
          state: testData,
          stateBuilder: (context, data) {
            return Text('test');
          });

      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: textFieldStateBuilder,
          ),
        ),
      );

      final textFinder = find.text('test');
      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'TextfieldStreamBuilder error test',
    (WidgetTester tester) async {
      final testData = TextFieldStreamedState('test');

      final textFieldStateBuilder = TextFieldStateBuilder(
          state: testData,
          stateBuilder: (context, data) {
            if (data.hasError) {
              return Text('error');
            }
            return Text('test');
          });

      unawaited(testData.error());
      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: textFieldStateBuilder,
          ),
        ),
      );

      final textFinder = find.text('error');
      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'TextfieldStreamBuilder loading test',
        (WidgetTester tester) async {
      final testData = TextFieldStreamedState('test');

      final textFieldStateBuilder = TextFieldStateBuilder(
          state: testData,
          stateBuilder: (context, data) {
            if (data.isLoading) {
              return Text('loading');
            }
            return Text('test');
          });

      unawaited(testData.loading());
      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: textFieldStateBuilder,
          ),
        ),
      );

      final textFinder = find.text('loading');
      expect(textFinder, findsOneWidget);
    },
  );
}
