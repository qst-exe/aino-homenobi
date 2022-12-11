import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/message_provider.dart';
import 'message_cell.dart';

class MessageContent extends StatelessWidget {
  const MessageContent({Key? key});

  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<MessageProvider>(context, listen: true);

    if (messageProvider.messages.length == 0) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: SelectableText('''
AIノほめのびくんに愚痴を話してなぐさめてもらいましょう！
投稿内容はAIノほめのびくんのサーバには保存されず、AIノほめのびくんも忘れてしまいます！
※ たまに不機嫌になることがあるので、ご了承くださいm(_ _)m
''',
            style: GoogleFonts.notoSansJavanese(
                textStyle: Theme.of(context).textTheme.bodyText1, height: 1.5)),
      ));
    }

    return ListView.builder(
      itemCount: messageProvider.messages.length,
      itemBuilder: (BuildContext context, int index) {
        final message = messageProvider.messages[index];
        return MessageCell(message: message);
      },
    );
  }
}
