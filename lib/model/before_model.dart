import 'stories_model.dart';

/// 过往消息
class BeforeData {
  String date;
  List<Stories> stories;

  BeforeData({this.date, this.stories});

  BeforeData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['stories'] != null) {
      stories = new List<Stories>();
      json['stories'].forEach((v) {
        stories.add(new Stories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.stories != null) {
      data['stories'] = this.stories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

