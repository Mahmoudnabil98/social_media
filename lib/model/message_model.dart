class MessageModel {
  String? senderId;
  String? receiverId;
  String? text;
  String? dataTime;
  String? image;
  MessageModel(
      {this.dataTime, this.receiverId, this.senderId, this.text, this.image});

  MessageModel.fromJson(Map map) {
    senderId = map['senderId'];
    receiverId = map['receiverId'];
    text = map['text'];
    dataTime = map['dataTime'];
    image = map['image'];
  }

  toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'dataTime': dataTime,
      'image': image,
    };
  }
}
