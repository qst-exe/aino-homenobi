import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:praise_with_ai/data/model/message.dart';
import 'package:praise_with_ai/data/provider/message_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'message_provider_test.mocks.dart';

// message_provider.dart に関するテスト
@GenerateMocks([SharedPreferences])
void main() {
  MockSharedPreferences? mockSharedPreferences;
  List<Message>? mockMessages;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockMessages = [
      Message(text: '私の投稿', isSelf: true, createdAt: DateTime.now()),
      Message(text: 'AIノほめのびくんの回答', isSelf: false, createdAt: DateTime.now()),
    ];

    when(mockSharedPreferences!.getString('messages'))
        .thenReturn(jsonEncode(mockMessages));

    when(mockSharedPreferences!.remove('messages'))
        .thenAnswer((_) => Future.value(true));

    when(mockSharedPreferences!.setString('messages', any))
        .thenAnswer((_) => Future.value(true));
  });

  group('MessageProvider', () {
    test('messages', () {
      final messageProvider = MessageProvider(mockSharedPreferences!);

      expect(messageProvider.messages.length, 2);
      expect(messageProvider.messages, mockMessages);
    });

    test('resetMessage', () {
      final messageProvider = MessageProvider(mockSharedPreferences!);
      messageProvider.resetMessage();

      expect(messageProvider.messages.length, 0);
    });

    test('setMessage', () {
      final messageProvider = MessageProvider(mockSharedPreferences!);

      messageProvider.setMessage('最後の投稿');

      expect(messageProvider.messages.length, 3);
      expect(messageProvider.messages[2].text, '最後の投稿');
    });
  });
}
