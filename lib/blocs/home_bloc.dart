import 'package:flutter_zhihu_daily/blocs/bloc_base.dart';
import 'package:flutter_zhihu_daily/service/service.dart';

abstract class HomeEvent{}

class RefreshEvent extends HomeEvent{}
class LoadMoreEvent extends HomeEvent{}
class CompleteEvent extends HomeEvent{}

enum LoadStatus { idle, refresh,loadMore,complete, fail }

class HomeState extends BaseState {
  List data;
  LoadStatus loadStatus;
  String title;

  HomeState(this.data, this.loadStatus,this.title)
      : super([data, loadStatus,title]);

  HomeState clone() => HomeState(data, loadStatus,title);
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  String todayDate;//今日热闻时间
  String currentDate;//当前加载的时间

  @override
  HomeState get initialState =>genInitialState();

  HomeState genInitialState()=>HomeState([], LoadStatus.idle,"首页");

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event.runtimeType) {
      case RefreshEvent:
        if(isLoading()) break;
        yield* _doRefresh();
        break;
      case LoadMoreEvent:
        if(isLoading()) break;
        yield* _doLoadMore();
        break;
      case CompleteEvent:
        yield* _doComplete();
        break;
    }
  }

  Stream<HomeState> _doRefresh() async* {
    //更新刷新状态
    yield currentState.clone()..loadStatus = LoadStatus.refresh;
    //请求最新数据
    var latest = await dailyService.getLatest();
    currentDate=todayDate=latest.date;

    //重新组装数据
    var newState = genInitialState();
    newState.loadStatus=LoadStatus.complete;
    var data = newState.data;
    data
      ..add(latest.topStories)
      ..add(Label(latest.date))
      ..addAll(latest.stories);
    yield newState;
  }

  Stream<HomeState> _doLoadMore() async* {
    //更新刷新状态
    yield currentState.clone()..loadStatus = LoadStatus.loadMore;
    //请求当前时间前一天的数据
    var beforeData = await dailyService.getBefore(currentDate);
    currentDate=beforeData.date;
    //添加数据
    yield currentState.clone()
      ..data.add(Label(beforeData.date))
      ..data.addAll(beforeData.stories)
      ..loadStatus=LoadStatus.idle;
  }

  bool isLoading()=>
      currentState.loadStatus ==LoadStatus.refresh
      ||currentState.loadStatus ==LoadStatus.loadMore;

  Stream<HomeState> _doComplete() async* {
    yield currentState.clone()..loadStatus=LoadStatus.idle;
  }
}
