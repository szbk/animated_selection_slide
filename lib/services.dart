import 'dart:convert';
import 'package:inbox_mail/model.dart';
import 'package:flutter/services.dart';


 Future<List<CardMessage>> cardList() async {
    String responseJson = await rootBundle.loadString('assets/data.json');
    List cards = json.decode(responseJson);
    List<CardMessage> listCard =
        cards.map((card) => CardMessage.fromJson(card)).toList();

    return listCard;
  }
