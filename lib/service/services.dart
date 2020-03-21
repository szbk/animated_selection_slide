import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:inbox_mail/model/model.dart';

class MessageService {
  static MessageService _instance;
  static MessageService get instance {
    if (_instance == null) {
      _instance = MessageService._init();
    }
    return _instance;
  }

  MessageService._init();

  Future<List<CardMessage>> cardList() async {
    String responseJson = await rootBundle.loadString('assets/data.json');
    List cards = json.decode(responseJson);
    List<CardMessage> listCard =
        cards.map((card) => CardMessage.fromJson(card)).toList();

    return listCard;
  }
}
