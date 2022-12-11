import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class LinkButton extends StatelessWidget {
  LinkButton({required this.label, required this.onClick, Key? key})
      : super(key: key);
  String label;
  Function onClick;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => onClick(),
        child: Text(
          label,
          style: GoogleFonts.notoSansJavanese(
            textStyle: Theme.of(context).textTheme.bodyText1,
            color: Colors.blue,
            fontSize: 12,
          ),
        ));
  }
}
