import 'package:flutter/material.dart';
import 'package:flutter_zhihu_daily/blocs/home_bloc.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zhihu_daily/blocs/theme_bloc.dart';
import 'package:flutter_zhihu_daily/component/stories_item.dart';
import 'package:flutter_zhihu_daily/page/detail_page.dart';
import 'package:flutter_zhihu_daily/resources/images_path.dart';
import 'package:flutter_zhihu_daily/resources/icon_font_data.dart';
import '../widget/pull_up_listener.dart';
import 'package:flutter_zhihu_daily/model/models.dart';
import '../component/top_stories.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;
  Completer _refreshCompleter;
  GlobalKey<RefreshIndicatorState> _refreshKey;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc();
    _refreshCompleter = Completer();
    _refreshKey = GlobalKey();

    ///监听到第一帧绘制后，刷新一下数据
    WidgetsBinding.instance.addPostFrameCallback((Duration d) {
      _refreshKey.currentState?.show();
    });
    _scrollController = ScrollController()..addListener(_onScrollChange);
  }

  void _onScrollChange() {
    // todo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        drawer: _buildDrawer(context),
        body: _buildBody(context));
  }

  AppBar _buildAppBar(BuildContext context) {
    ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);
    return AppBar(
      title: BlocBuilder(
          bloc: _homeBloc,
          builder: (_, HomeState state) {
            return Text('${state.title}');
          }),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              IconFontData.ring,
            ),
            onPressed: () {
              _homeBloc.dispatch(RefreshEvent());
            }),
        BlocBuilder(
          bloc: themeBloc,
          builder: (_, ThemeState state) => PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text(state.isDarkTheme ? '日间模式' : '夜间模式'),
                      value: 0,
                    ),
                    PopupMenuItem(
                      child: Text('设置选项'),
                      value: 1,
                    )
                  ];
                },
                onSelected: (index) {
                  switch (index) {
                    case 0:
                      themeBloc.dispatch(ThemeToggleEvent());
                      break;
                    case 1:
                      break;
                  }
                },
              ),
        ),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: EdgeInsets.all(0),
            accountName: Text(
              "Flutter知乎日报",
            ),
            accountEmail: Text("版本 1.0"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(ImageAssets.account_avatar),
            ),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: Text('我的收藏'),
                leading: Icon(Icons.star),
                onTap: () {},
              ),
              ListTile(
                title: Text('离线下载'),
                leading: Icon(Icons.file_download),
                onTap: () {},
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return RefreshIndicator(
        key: _refreshKey,
        child: BlocListener(
          bloc: _homeBloc,
          listener: (BuildContext context, HomeState state) {
            if (state.loadStatus == LoadStatus.complete) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              _homeBloc.dispatch(CompleteEvent());
            }
          },
          child: PullUpListener(
            child: _buildContent(context),
            onPullUpListener: () {
              _homeBloc.dispatch(LoadMoreEvent());
            },
          ),
        ),
        onRefresh: () {
          _homeBloc.dispatch(RefreshEvent());
          return _refreshCompleter.future;
        });
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder(
        bloc: _homeBloc,
        builder: (_, HomeState state) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                _buildListItem(context, state.data[index]),
            itemCount: state.data.length,
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
          );
        });
  }

  Widget _buildListItem(BuildContext context, item) {
    if (item is List<TopStories>) {
      return TopStoriesWidget(
        data: item,
        onTopStoriesClick: (topStories, index) =>
            _navigateToDetails(topStories.id),
      );
    } else if (item is Label) {
      return Padding(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 5),
        child:
            Text(item.date == _homeBloc.todayDate ? "今日热闻" : item.toString()),
      );
    } else if (item is Stories) {
      return StoriesItem(
        stories: item,
        onStoriesClick: (stories) => _navigateToDetails(stories.id),
      );
    } else {
      return Container();
    }
  }

  ///跳转到详情页 [DetailPage]
  void _navigateToDetails(int id) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DetailPage(
        id: id,
      );
    }));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshCompleter?.complete();
    super.dispose();
  }
}
