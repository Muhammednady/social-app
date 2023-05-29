class PostModel {
  // 'name':name,
  //'date':date,
  //'post':post,
  //'image':ImageUrl

  String? name;
  String? image;
  String? date;
  String? post;
  String? postImage;
  String? uID;
  bool likes = false;

  PostModel(
      {required this.name,
      required this.image,
      required this.uID,
      required this.date,
      required this.post,
      required this.postImage});

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    uID = json['uID'];
    date = json['date'];
    post = json['post'];
    likes = json['likes'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'date': date,
      'uID': uID,
      'post': post,
      'postImage': postImage,
      'likes':likes
    };
  }
}
