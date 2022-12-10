import 'dart:core';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/message_content.dart';
import 'firebase_options.dart';
import 'provider/message_provider.dart';

Future<void> main() async {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  MyApp({required this.prefs, Key? key});
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MessageProvider>(
          create: (context) => MessageProvider(prefs),
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
        title: Text(
          'AIノほめのびくん',
          style: GoogleFonts.notoSansJavanese(
              textStyle: Theme.of(context).textTheme.bodyText1,
              color: Colors.white),
        ),
        actions: [
          ElevatedButton.icon(
            icon: FaIcon(FontAwesomeIcons.trash),
              onPressed: () {
                messageProvider.resetMessage();
              },
              label: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 0),
                child: Text(
                  "履歴を削除",
                  style: GoogleFonts.notoSansJavanese(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      color: Colors.white),
                ),
              ))
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: MessageContent(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            width: 250.0,
                            child: (messageProvider.isLoading)
                                ? DefaultTextStyle(
                                    style: GoogleFonts.notoSansJavanese(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        color: Colors.grey,
                                        fontSize: 12),
                                    child: AnimatedTextKit(
                                      animatedTexts: [
                                        TypewriterAnimatedText(
                                          'AIノほめのびくんが返信中',
                                          cursor: '...',
                                          speed: Duration(milliseconds: 150),
                                        ),
                                      ],
                                      isRepeatingAnimation: true,
                                      onTap: () {
                                        print("Tap Event");
                                      },
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.pink,
                                  width: 2,
                                ),
                              ),
                              hintText: '「疲れた」などAIノほめのびくんに愚痴ってみましょう',
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth > 765 ? 8 : 4),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: screenWidth > 765
                              ? ElevatedButton.icon(
                                  icon: FaIcon(FontAwesomeIcons.paperPlane),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      postMessage(
                                          messageProvider, _controller.text);
                                      _controller.clear();
                                    }
                                  },
                                  label: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 5, right: 5, bottom: 10),
                                    child: Text(
                                      '話す',
                                      style: GoogleFonts.notoSansJavanese(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          color: Colors.white,
                                          height: 1.5),
                                    ),
                                  ),
                                )
                              : IconButton(
                                  color: Colors.pink,
                                  icon: FaIcon(FontAwesomeIcons.paperPlane),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      postMessage(
                                          messageProvider, _controller.text);
                                      _controller.clear();
                                    }
                                  },
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      _launchUrl("https://beta.openai.com/");
                    },
                    child: Text(
                      "ほめのびくんの利用AIについて",
                      style: GoogleFonts.notoSansJavanese(
                          textStyle: Theme.of(context).textTheme.bodyText1,
                          color: Colors.blue,
                          fontSize: 12,
                      ),
                    )),
                Text('© 2022 kusutan',
                    style: GoogleFonts.notoSansJavanese(
                        textStyle: Theme.of(context).textTheme.bodyText1,
                        color: Colors.grey
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  void postMessage(MessageProvider messageProvider, String text) {
    messageProvider.setMessage(text);
    messageProvider.getReply(text);
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
