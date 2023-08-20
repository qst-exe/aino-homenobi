import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:praise_with_ai/app.dart';
import 'package:praise_with_ai/data/model/message.dart';

import 'mock_shared_preferences.dart';

// app.dart が適切に表示されるかのテスト
void main() {
  MockSharedPreferences? mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
  });

  testWidgets('Show empty Home page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(App(
      prefs: mockSharedPreferences!,
    ));

    // Verify that home page is shown.
    expect(find.text('AIノほめのびくん'), findsOneWidget);
    expect(find.text('履歴を削除'), findsOneWidget);
    expect(
        find.text(
            'AIノほめのびくんに愚痴を話してなぐさめてもらいましょう！\n投稿内容はAIノほめのびくんのサーバには保存されず、AIノほめのびくんも忘れてしまいます！\n※ たまに不機嫌になることがあるので、ご了承くださいm(_ _)m\n'),
        findsOneWidget);
    expect(find.text('AIノほめのびくんに言いたいこと'), findsOneWidget);
    expect(find.text('話す'), findsOneWidget);
  });

  testWidgets('Show some messages Home page', (WidgetTester tester) async {
    DateFormat outputFormat = DateFormat('HH:mm');

    List<Message> mockMessages = [
      Message(text: '私の投稿', isSelf: true, createdAt: DateTime.now()),
      Message(text: 'AIノほめのびくんの回答', isSelf: false, createdAt: DateTime.now()),
    ];
    when(mockSharedPreferences!.getString('messages'))
        .thenReturn(jsonEncode(mockMessages));

    // Build our app and trigger a frame.
    await tester.pumpWidget(App(
      prefs: mockSharedPreferences!,
    ));

    // Verify that home page is shown.
    expect(find.text('AIノほめのびくん'), findsNWidgets(2));
    expect(find.text('私の投稿'), findsOneWidget);
    expect(find.text('AIノほめのびくんの回答'), findsOneWidget);
    expect(find.text("${outputFormat.format(mockMessages[0].createdAt)}\n既読"),
        findsOneWidget);
  });
}
