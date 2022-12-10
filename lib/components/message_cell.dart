import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '/data/model/message.dart';

class MessageCell extends StatelessWidget {
  const MessageCell({required this.message, Key? key});
  final Message message;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
        padding: const EdgeInsets.only(
            left: 10, top: 10, bottom: 10, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getFace(message),
            Padding(
              padding: EdgeInsets.only(
                  left: message.isSelf ? 70 : 10),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      message.isSelf
                          ? Container()
                          : Text(
                        'AIノほめのびくん',
                        overflow:
                        TextOverflow.ellipsis,
                        style: GoogleFonts.notoSansJavanese(
                            textStyle: Theme.of(context).textTheme.bodyText1,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: message.isSelf
                            ? screenWidth - 200
                            : 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
                    decoration: BoxDecoration(
                        color: getBgColor(message),
                        borderRadius:
                        const BorderRadius.all(
                            Radius.circular(10))),
                    width: screenWidth - 100,
                    child: SelectableText(
                      message.text,
                      style: GoogleFonts.notoSansJavanese(
                          textStyle: Theme.of(context).textTheme.bodyText1, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  getFace(Message message) {
    if (message.isSelf) {
      return Container();
    }

    if (message.isCool) {
      return FaIcon(FontAwesomeIcons.faceMeh);
    }

    return FaIcon(FontAwesomeIcons.faceSmileWink);
  }

  getBgColor(Message message) {
    if (message.isSelf) {
      return Colors.grey[200];
    }

    if (message.isCool) {
      return Colors.lightBlue[200];
    }

    return Colors.pink[100];
  }
}

