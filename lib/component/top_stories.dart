import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_zhihu_daily/model/models.dart';
import 'package:cached_network_image/cached_network_image.dart';

//首页轮播图
class TopStoriesWidget extends StatefulWidget{
  final double paginationSpace=2;
  final double paginationSize=7;
  final double paginationMargin=7;

  final List<TopStories> data;
  final OnTopStoriesClick onTopStoriesClick;

  TopStoriesWidget({Key key,@required this.data,this.onTopStoriesClick}):
        assert(data!=null),
        super(key:key);

  @override
  _TopStoriesWidgetState createState() => _TopStoriesWidgetState();
}

class _TopStoriesWidgetState extends State<TopStoriesWidget>{

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: Swiper(
        itemCount: widget.data.length,
        itemBuilder: (BuildContext context,int index){
          TopStories topStories=widget.data[index];
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image(
                image: CachedNetworkImageProvider(topStories.image),
                fit: BoxFit.cover,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.black.withAlpha(10),
                          Colors.black.withAlpha(60),
                          Colors.black.withAlpha(150),
                        ],
                        begin: AlignmentDirectional.topCenter,stops:[0,0.7,1],
                        end: AlignmentDirectional.bottomCenter,
                        tileMode: TileMode.clamp
                    )
                ),
              ),
              Container(
                child: Builder(builder: (_){
                  var textStyle=Theme.of(context).primaryTextTheme.title;
                  //在原来的基础上增大两个字号
                  textStyle=textStyle.copyWith(fontSize: textStyle.fontSize+2);
                  return DefaultTextStyle(
                    style: textStyle,
                    child: Text(
                      topStories.title,
                    ),
                  );
                }),
                alignment: AlignmentDirectional.bottomStart,
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: widget.paginationMargin*2
                      +widget.paginationSize
                      +widget.paginationSpace*2
                ),
              ),
            ],
          );
        },
        pagination: SwiperPagination(
          margin: EdgeInsets.all(widget.paginationMargin),
          builder: DotSwiperPaginationBuilder(
            color: Colors.grey,
            size: widget.paginationSize,
            activeColor: Colors.white,
            activeSize: widget.paginationSize,
            space: widget.paginationSpace
          )
        ),
        autoplay: true,
        onTap: (int index){
          if(widget.onTopStoriesClick!=null){
            widget.onTopStoriesClick(widget.data[index],index);
          }
        },
      ),
    );
  }

}

typedef OnTopStoriesClick = Function(TopStories topStories,int index);
