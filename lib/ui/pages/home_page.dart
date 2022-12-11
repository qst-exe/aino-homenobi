import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/ai_footer.dart';
import '../components/ai_input.dart';
import '../components/delete_button.dart';
import '../components/message_content.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: Text(
          'AIノほめのびくん',
          style: GoogleFonts.notoSansJavanese(
              textStyle: Theme.of(context).textTheme.bodyText1,
              color: Colors.white),
        ),
        actions: [
          DeleteButton(),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageContent(),
          ),
          AiInput(
            controller: _controller,
          ),
          AiFooter(),
        ],
      ),
    );
  }
}
