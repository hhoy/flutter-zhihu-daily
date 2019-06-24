///消息详情内容
class Detail {
  String body;
  String imageSource;
  String title;
  String image;
  String shareUrl;
  List<String> js;
  String gaPrefix;
  List<String> images;
  int type;
  int id;
  List<String> css;

  Detail(
      {this.body,
        this.imageSource,
        this.title,
        this.image,
        this.shareUrl,
        this.js,
        this.gaPrefix,
        this.images,
        this.type,
        this.id,
        this.css});

  Detail.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    imageSource = json['image_source'];
    title = json['title'];
    image = json['image'];
    shareUrl = json['share_url'];
    js = json['js'].cast<String>();
    gaPrefix = json['ga_prefix'];
    images = json['images'].cast<String>();
    type = json['type'];
    id = json['id'];
    css = json['css'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['image_source'] = this.imageSource;
    data['title'] = this.title;
    data['image'] = this.image;
    data['share_url'] = this.shareUrl;
    data['js'] = this.js;
    data['ga_prefix'] = this.gaPrefix;
    data['images'] = this.images;
    data['type'] = this.type;
    data['id'] = this.id;
    data['css'] = this.css;
    return data;
  }
}
