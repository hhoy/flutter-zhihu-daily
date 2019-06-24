import 'stories_model.dart';
export 'stories_model.dart';
export 'label_model.dart';
/// 最新消息
class LatestData {
  String date;
  List<Stories> stories;
  List<TopStories> topStories;

  LatestData({this.date, this.stories, this.topStories});

  LatestData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['stories'] != null) {
      stories = new List<Stories>();
      json['stories'].forEach((v) {
        stories.add(new Stories.fromJson(v));
      });
    }
    if (json['top_stories'] != null) {
      topStories = new List<TopStories>();
      json['top_stories'].forEach((v) {
        topStories.add(new TopStories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.stories != null) {
      data['stories'] = this.stories.map((v) => v.toJson()).toList();
    }
    if (this.topStories != null) {
      data['top_stories'] = this.topStories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopStories {
  String image;
  int type;
  int id;
  String gaPrefix;
  String title;

  TopStories({this.image, this.type, this.id, this.gaPrefix, this.title});

  TopStories.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    type = json['type'];
    id = json['id'];
    gaPrefix = json['ga_prefix'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['type'] = this.type;
    data['id'] = this.id;
    data['ga_prefix'] = this.gaPrefix;
    data['title'] = this.title;
    return data;
  }
}
