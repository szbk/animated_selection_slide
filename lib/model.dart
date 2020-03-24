class CardMessage {
  String id;
  String avatar;
  String name;
  String message;
  String time;

  CardMessage({this.id, this.avatar, this.name, this.message, this.time});

  factory CardMessage.fromJson(Map<String, dynamic> json) {
    return CardMessage(
      id: json["id"],
      avatar: json['avatar'],
      name: json['name'],
      message: json['message'],
      time: json['time'],
    );
  }
}
