import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zhihu_daily/model/stories_model.dart';
import 'package:flutter_zhihu_daily/resources/images_path.dart';

class StoriesItem extends StatelessWidget {
  final Stories stories;
  final OnStoriesClick onStoriesClick;

  static const BorderRadius _borderRadius =
      BorderRadius.all(Radius.circular(7));

  StoriesItem({Key key, @required this.stories, this.onStoriesClick})
      : assert(stories != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: _borderRadius),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: InkWell(
          onTap: onClick,
          borderRadius: _borderRadius,
          child: AspectRatio(
            aspectRatio: 3.9,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          stories.title,
                          style: TextStyle(inherit: true, fontSize: 17),
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  AspectRatio(
                    aspectRatio: 1.15,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image(
                          image: CachedNetworkImageProvider(
                            stories.images.first,
                          ),
                          fit: BoxFit.cover
                        ),
                        Offstage(
                          offstage: !stories.multipic,
                          child: FractionallySizedBox(
                            widthFactor: 0.5,
                            heightFactor: 0.25,
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Image.asset(ImageAssets.multi_pic),
                          ),
                        ),

                        /*Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          widthFactor: 0.5,
                          heightFactor: 0.25,
                          child: Image.asset(ImageAssets.multi_pic,fit: BoxFit.fill,),
                        )*/
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void onClick() {
    if (onStoriesClick != null) {
      onStoriesClick(stories);
    }
  }
}

typedef OnStoriesClick = Function(Stories stories);
