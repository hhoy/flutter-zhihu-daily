import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import '../service/daily_service.dart';

abstract class DetailEvent{}

//请求详情
class GetDetailEvent extends DetailEvent{
  int id;
  GetDetailEvent(this.id);
}

//通知WebView状态改变
class WebViewStatusEvent extends DetailEvent{
  final WebViewStatus webViewStatus;

  WebViewStatusEvent(this.webViewStatus):
      assert(webViewStatus!=null);

}

//数据状态
enum DataStatus{
  init,loading,complete,error
}

enum WebViewStatus{
  init,created,loaded
}

class DetailState extends Equatable{
  Detail detail;//数据
  DataStatus status;
  WebViewStatus webViewStatus;//WebView状态

  DetailState({
    this.detail,
    this.status=DataStatus.init,
    this.webViewStatus=WebViewStatus.init
  }): assert(status!=null),
      super([detail,status,webViewStatus]);

}

class DetailBloc extends Bloc<DetailEvent,DetailState>{
  @override
  get initialState => DetailState();

  @override
  Stream<DetailState> mapEventToState(event)async* {
    if(event is GetDetailEvent){
      yield DetailState(
          status: DataStatus.loading,
          webViewStatus: currentState.webViewStatus
      );
      Detail detail= await dailyService.getDetail(event.id);
      yield DetailState(
          detail: detail,
          status: DataStatus.complete,
          webViewStatus: currentState.webViewStatus
      );
    }else if(event is WebViewStatusEvent){
      yield DetailState(
          detail: currentState.detail,
          status: currentState.status,
          webViewStatus: event.webViewStatus
      );
    }
  }

}