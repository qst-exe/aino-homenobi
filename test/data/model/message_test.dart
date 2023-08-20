import 'package:flutter_test/flutter_test.dart';
import 'package:praise_with_ai/data/model/message.dart';

// message.dart に関するテスト
void main() {
  group('Message', () {
    test('fromJson', () {
      final json = {
        'text': 'test message',
        'createdAt': '2021-01-01T00:00:00.000Z',
      };
      final message = Message.fromJson(json);

      expect(message.text, 'test message');
      expect(message.createdAt, DateTime.parse('2021-01-01T00:00:00.000Z'));
    });

    test('toJson', () {
      final message = Message(
        text: 'test message',
        createdAt: DateTime.parse('2021-01-01T00:00:00.000Z'),
      );
      final json = message.toJson();

      expect(json['text'], 'test message');
      expect(json['createdAt'], '2021-01-01T00:00:00.000Z');
    });

    test('copyWith', () {
      final message = Message(
        text: 'test message',
        createdAt: DateTime(2021, 1, 1),
      );
      final copiedMessage = message.copyWith(
        text: 'test message2',
        createdAt: DateTime(2021, 1, 2),
      );

      expect(copiedMessage.text, 'test message2');
      expect(copiedMessage.createdAt, DateTime(2021, 1, 2));
    });
  });
}
