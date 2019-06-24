///消息列表
class Stories {
  List<String> images;
  int type;
  int id;
  String gaPrefix;
  String title;
  bool multipic;

  Stories({this.images, this.type, this.id, this.gaPrefix, this.title,this.multipic=false });

  Stories.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    type = json['type'];
    id = json['id'];
    gaPrefix = json['ga_prefix'];
    title = json['title'];
    multipic=json['multipic']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['type'] = this.type;
    data['id'] = this.id;
    data['ga_prefix'] = this.gaPrefix;
    data['title'] = this.title;
    data['multipic']=this.multipic;
    return data;
  }
}