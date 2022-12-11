import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../data/provider/message_provider.dart';

// ignore: must_be_immutable
class AiInput extends StatelessWidget {
  AiInput({required this.controller, Key? key}) : super(key: key);
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final screenWidth = MediaQuery.of(context).size.width;

    final messageProvider = Provider.of<MessageProvider>(context, listen: true);

    return Align(
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
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText1,
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
                      controller: controller,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.pink,
                            width: 2,
                          ),
                        ),
                        hintText: '「疲れた」などと愚痴ってみましょう',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          textBaseline: TextBaseline.ideographic,
                        ),
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
                          postMessage(messageProvider, controller.text);
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink[300],
                            ),
                            icon: FaIcon(FontAwesomeIcons.paperPlane),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                postMessage(messageProvider, controller.text);
                              }
                            },
                            label: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 5, right: 5, bottom: 10),
                              child: Text(
                                '話す',
                                style: GoogleFonts.notoSansJavanese(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText1,
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
                                postMessage(messageProvider, controller.text);
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
    );
  }

  void postMessage(MessageProvider messageProvider, String text) {
    messageProvider.setMessage(text);
    messageProvider.getReply(text);
    controller.clear();
  }
}
