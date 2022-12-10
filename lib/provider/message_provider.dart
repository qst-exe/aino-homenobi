import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/message.dart';

final functions = FirebaseFunctions.instance;
const localStorageKey = 'messages';

class MessageProvider with ChangeNotifier {
  List<Message> messages = [];
  SharedPreferences? prefs;

  MessageProvider() {
    SharedPreferences.getInstance().then((preferences) {
      prefs = preferences;
      init();
    });
  }

  void init() {
    try {
      final res = prefs!.getString(localStorageKey);
      if (res!.isNotEmpty) {
        final decodedData = json.decode(res) as List<dynamic>;
        final newMessages = decodedData.map((data) => Message(
            text: data['text'],
            isCool: data['isSelf'],
            isSelf: data['isSelf']
        )).toList();
        messages.addAll(newMessages);
        notifyListeners();
      }
    } catch (e) {
      prefs!.remove(localStorageKey);
    }
  }

  void setMessage(String text) {
    final _myMessage = Message(text: text, isSelf: true);
    _update(_myMessage);
  }

  Future<void> getReply(String text) async {
    final postMessage = functions.httpsCallable('postMessage',);

    try {
      final postMessagePayload = {"message": text};
      final res = await postMessage(postMessagePayload);
      final _aiMessage = Message(text: res.data['reply'], isCool: res.data['isCool']);
      _update(_aiMessage);
    } catch (e) {
      print(e);
    }
  }

  void _update(Message message) {
    messages.add(message);
    final value = json.encode(messages);
    prefs!.setString(localStorageKey, value);
    notifyListeners();
  }
}
