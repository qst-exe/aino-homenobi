import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/message_provider.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final messageProvider = Provider.of<MessageProvider>(context, listen: true);

    if (screenWidth > 765) {
      return _pcDeleteButton(context, messageProvider);
    }
    return _spDeleteButton(context, messageProvider);
  }

  Widget _pcDeleteButton(
      BuildContext context, MessageProvider messageProvider) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            )),
        icon: FaIcon(FontAwesomeIcons.trash),
        onPressed: () {
          _delete(
            context,
            messageProvider,
          );
        },
        label: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 0),
          child: Text(
            "履歴を削除",
            style: GoogleFonts.notoSansJavanese(
                textStyle: Theme.of(context).textTheme.bodyText1,
                color: Colors.white),
          ),
        ));
  }

  Widget _spDeleteButton(
      BuildContext context, MessageProvider messageProvider) {
    return IconButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          )),
      icon: FaIcon(FontAwesomeIcons.trash),
      onPressed: () {
        _delete(
          context,
          messageProvider,
        );
      },
    );
  }

  void _delete(BuildContext context, MessageProvider messageProvider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text(
            "履歴を削除",
            style: GoogleFonts.notoSansJavanese(
              textStyle: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          content: Text(
            "AIノほめのびくんとの会話履歴を削除しますか？\n\nほめのびくんのデータは記録されていないので、一度削除すると復元できません。",
            style: GoogleFonts.notoSansJavanese(
                textStyle: Theme.of(context).textTheme.bodyText1, height: 1.5),
          ),
          actions: [
            TextButton(
              child: Text("削除しない",
                  style: GoogleFonts.notoSansJavanese(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      color: Colors.blueGrey[600])),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("削除する",
                  style: GoogleFonts.notoSansJavanese(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      color: Colors.pink)),
              onPressed: () {
                messageProvider.resetMessage();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
