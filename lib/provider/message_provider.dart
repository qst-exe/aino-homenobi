import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../data/model/message.dart';

final functions = FirebaseFunctions.instance;

class MessageProvider with ChangeNotifier {
  List<Message> messages = [];

  void setMessage(String text) {
    final _myMessage = Message(text: text, isSelf: true);
    _update(_myMessage);
  }

  Future<void> getReply(String text) async {
    final postMessage = functions.httpsCallable('postMessage',);

    try {
      final postMessagePayload = {"message": text};
      final res = await postMessage(postMessagePayload);
      final _aiMessage = Message(text: res.data['reply']);
      _update(_aiMessage);
    } catch (e) {
      print(e);
    }
  }

  void _update(Message message) {
    messages.add(message);
    notifyListeners();
  }
}
