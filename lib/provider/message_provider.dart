import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/message.dart';

final functions = FirebaseFunctions.instance;
const localStorageKey = 'messages';

class MessageProvider with ChangeNotifier {
  List<Message> messages = [];
  bool isLoading = false;
  SharedPreferences? prefs;

  MessageProvider(SharedPreferences sharedPreferences) {
    prefs = sharedPreferences;
    init();
  }

  void init() {
    try {
      final res = prefs!.getString(localStorageKey);
      if (res != null) {
        final decodedData = jsonDecode(res) as List<dynamic>;
        final newMessages= decodedData
            .map((data) => Message.fromJson(data))
            .toList();
        messages.addAll(newMessages);
      }
    } catch(error) {
      print(error);
      resetMessage();
    }
  }

  void setMessage(String text) {
    final _myMessage = Message(text: text, isSelf: true);
    isLoading = true;
    _update(_myMessage);
  }

  void resetMessage() {
    isLoading = false;
    messages = [];
    prefs!.remove(localStorageKey);
    notifyListeners();
  }

  Future<void> getReply(String text) async {
    final postMessage = functions.httpsCallable('postMessage',);

    try {
      final postMessagePayload = {"message": text};
      final res = await postMessage(postMessagePayload);
      final _aiMessage = Message(text: res.data['reply'], isCool: res.data['isCool']);
      isLoading = false;
      _update(_aiMessage);
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
    }
  }

  void _update(Message message) {
    messages.add(message);
    final savedData = jsonEncode(messages);
    prefs!.setString(localStorageKey, savedData);
    notifyListeners();
  }
}
