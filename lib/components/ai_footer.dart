import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/license_provider.dart';
import 'link_button.dart';

class AiFooter extends StatelessWidget {
  const AiFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final licenseProvider = Provider.of<LicenseProvider>(context, listen: true);

    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      children: [
        LinkButton(
          label: "ほめのびくんの利用AIについて",
          onClick: () {
            _launchUrl("https://beta.openai.com/");
          },
        ),
        LinkButton(
          label: "ライセンス",
          onClick: () async {
            _showAlert(context, licenseProvider);
          },
        ),
        LinkButton(
          label: "© 2022 kusutan",
          onClick: () async {
            _launchUrl("https://twitter.com/qst_exe");
          },
        ),
      ],
    );
  }

  Future<void> _showAlert(
      BuildContext context, LicenseProvider licenseProvider) async {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double modalWidth = screenWidth >= 380 ? screenWidth - 100 : 270;

    await showDialog<void>(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('ライセンス',
                style: GoogleFonts.notoSansJavanese(
                  textStyle: Theme.of(context).textTheme.bodyText1,
                )),
            content: Container(
              width: modalWidth,
              height: screenHeight - 100,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: licenseProvider.licenses.length,
                itemBuilder: (BuildContext context, int index) {
                  final license = licenseProvider.licenses[index];
                  return Container(
                    child: Column(
                      children: [
                        SelectableText(license.packageName,
                            style: GoogleFonts.notoSansJavanese(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText1,
                                color: Colors.blueGrey[700])),
                        SelectableText(license.paragraphText,
                            style: GoogleFonts.notoSansJavanese(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText1,
                                color: Colors.blueGrey,
                                height: 1.5)),
                      ],
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('閉じる',
                    style: GoogleFonts.notoSansJavanese(
                        textStyle: Theme.of(context).textTheme.bodyText1,
                        color: Colors.pink)),
              ),
            ],
          );
        });
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
