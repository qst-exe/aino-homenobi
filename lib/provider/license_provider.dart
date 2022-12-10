import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/model/license.dart';

class LicenseProvider with ChangeNotifier {
  List<License> licenses = [];

  LicenseProvider() {
    LicenseRegistry.licenses.listen((license) {
      final packageName = license.packages.toList().map((e) => e).join('');
      final paragraphText =
          license.paragraphs.toList().map((e) => e.text).join('\n');
      licenses
          .add(License(packageName: packageName, paragraphText: paragraphText));
    });
  }
}
