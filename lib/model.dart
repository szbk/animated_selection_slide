class CardMessage {
  String avatar;
  String name;
  String message;
  String time;

  CardMessage({this.avatar, this.name, this.message, this.time});

  factory CardMessage.fromJson(Map<String, dynamic> json) {
    return CardMessage(
      avatar: json['avatar'],
      name: json['name'],
      message: json['message'],
      time: json['time'],
    );
  }
}
