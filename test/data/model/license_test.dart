import 'package:flutter_test/flutter_test.dart';
import 'package:praise_with_ai/data/model/license.dart';

// license.dart に関するテスト
void main() {
  group('License', () {
    test('fromJson', () {
      final json = {
        'packageName': 'test',
        'paragraphText': 'test license',
      };
      final license = License.fromJson(json);

      expect(license.packageName, 'test');
      expect(license.paragraphText, 'test license');
    });

    test('toJson', () {
      final license = License(
        packageName: 'test',
        paragraphText: 'test license',
      );
      final json = license.toJson();

      expect(json['packageName'], 'test');
      expect(json['paragraphText'], 'test license');
    });

    test('copyWith', () {
      final license = License(
        packageName: 'test',
        paragraphText: 'test license',
      );
      final copiedLicense = license.copyWith(
        packageName: 'test2',
        paragraphText: 'test license2',
      );

      expect(copiedLicense.packageName, 'test2');
      expect(copiedLicense.paragraphText, 'test license2');
    });
  });
}
