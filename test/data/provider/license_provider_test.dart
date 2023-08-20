import 'package:flutter_test/flutter_test.dart';
import 'package:praise_with_ai/data/provider/license_provider.dart';

// license_provider.dart に関するテスト
void main() {
  group('LicenseProvider', () {
    test('licenses', () {
      final licenseProvider = LicenseProvider();

      expect(licenseProvider.licenses, []);
    });
  });
}
