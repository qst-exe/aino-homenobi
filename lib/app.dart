import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/provider/license_provider.dart';
import 'data/provider/message_provider.dart';
import 'ui/pages/home_page.dart';

// ignore: must_be_immutable
class App extends StatelessWidget {
  App({required this.prefs, Key? key});
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LicenseProvider>(
          create: (context) => LicenseProvider(),
        ),
        ChangeNotifierProvider<MessageProvider>(
          create: (context) => MessageProvider(prefs),
        ),
      ],
      child: MaterialApp(
        title: 'AIノほめのびくん',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: HomePage(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ja', 'JP'),
        ],
        locale: const Locale('ja', 'JP'),
      ),
    );
  }
}
