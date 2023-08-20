import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:praise_with_ai/data/provider/license_provider.dart';
import 'package:praise_with_ai/data/provider/message_provider.dart';
import 'package:praise_with_ai/ui/components/ai_footer.dart';
import 'package:provider/provider.dart';

import '../../mock_shared_preferences.dart';

// ai_footer.dart が適切に表示されるかのテスト
void main() {
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
  });

  testWidgets('show ai footer', (WidgetTester tester) async {
    final prefs = MockSharedPreferences();
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<LicenseProvider>(
              create: (context) => LicenseProvider()),
          ChangeNotifierProvider<MessageProvider>(
              create: (context) => MessageProvider(prefs)),
          // 他のProviderもここに追加
        ],
        child: const MaterialApp(
          home: AiFooter(),
        ),
      ),
    );

    // Verify that ai footer is shown.
    expect(find.text('ほめのびくんの利用AIについて'), findsOneWidget);
    expect(find.text('ライセンス'), findsOneWidget);
    expect(find.text('ほめのびくんの利用AIについて'), findsOneWidget);
  });
}
