class PostModel {
  String? uId;
  String? name;
  String? image;
  String? text;
  String? dateTime;
  String? postImage;

  PostModel(
      {this.dateTime,
      this.image,
      this.name,
      this.postImage,
      this.uId,
      this.text});

  PostModel.fromJson(Map map) {
    uId = map['uId'];
    name = map['name'];
    text = map['text'];
    image = map['image'];
    postImage = map['postImage'];
    dateTime = map['dateTime'];
  }

  toJson() {
    return {
      'uId': uId,
      'name': name,
      'text': text,
      'image': image,
      'postImage': postImage,
      'dateTime': dateTime,
    };
  }
}
