import 'dart:core';

import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praise_with_ai/components/message_cell.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/material.dart';

import 'provider/message_provider.dart';


Future<void> main() async {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MessageProvider>(
          create: (context) => MessageProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'AIノほめのびくん',
        theme: ThemeData(
          primarySwatch: Colors.pink,
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

class HomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final _controller = TextEditingController();

    final messageProvider = Provider.of<MessageProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('AIノほめのびくん',
          style: GoogleFonts.notoSansJavanese(
              textStyle: Theme.of(context).textTheme.bodyText1, color: Colors.white),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: messageProvider.messages.length > 0 ? ListView.builder(
              itemCount: messageProvider.messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messageProvider.messages[index];
                return MessageCell(message: message);
              },
            ): Center(child: Text('AIノほめのびくんに愚痴を話してなぐさめてもらいましょう',
                style: GoogleFonts.notoSansJavanese(
                    textStyle: Theme.of(context).textTheme.bodyText1))
            ),),
          Align(
            alignment: Alignment.bottomCenter,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth - 150,
                    child: TextFormField(
                      textInputAction: TextInputAction.none,
                      controller: _controller,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.pink,
                            width: 2,
                          ),
                        ),
                        hintText: 'AIノほめのびくんに愚痴ってみましょう(例：疲れた)',
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.pink[200],
                        ),
                        labelText: 'AIノほめのびくんに言いたいこと',
                        floatingLabelStyle: const TextStyle(fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(244, 143, 177, 1),
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'メッセージが入力されていません';
                        }
                        return null;
                      },
                      onFieldSubmitted: (String? value) {
                        if (_formKey.currentState!.validate()) {
                          postMessage(messageProvider, _controller.text);
                        }
                      },
                    ),
                  ),
                  const Padding( padding: EdgeInsets.symmetric(horizontal: 8),),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton.icon(
                      icon: FaIcon(FontAwesomeIcons.comment),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          postMessage(messageProvider, _controller.text);
                          _controller.clear();
                        }
                      },
                      label: Padding(
                        padding: const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 10),
                        child: Text(
                          '話す',
                          style: GoogleFonts.notoSansJavanese(
                              textStyle: Theme.of(context).textTheme.bodyText1,
                              color: Colors.white,
                              height: 1.5
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void postMessage(MessageProvider messageProvider, String text) {
    messageProvider.setMessage(text);
    messageProvider.getReply(text);
  }
}
