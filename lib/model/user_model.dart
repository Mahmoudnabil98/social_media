class UserModel {
  String? name;
  String? phone;
  String? image;
  String? email;
  String? uid;
  bool? isEmailVerified;
  String? bio;
  String? coverImage;

  UserModel(
      {this.email,
      this.image,
      this.name,
      this.coverImage,
      this.phone,
      this.uid,
      this.bio,
      this.isEmailVerified = false});

  UserModel.fromJson(Map map) {
    name = map['name'];
    phone = map['phone'];
    image = map['image'];
    email = map['email'];
    coverImage = map['coverImage'];
    uid = map['uid'];
    isEmailVerified = map['isEmailVerified'];
    bio = map['bio'];
  }

  toJson() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'phone': phone,
      'uid': uid,
      'bio': bio,
      'coverImage': coverImage,
      'isEmailVerified': isEmailVerified,
    };
  }
}
