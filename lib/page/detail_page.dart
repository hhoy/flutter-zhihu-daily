import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_zhihu_daily/model/detail_model.dart';
import 'package:flutter_zhihu_daily/resources/icon_font_data.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_zhihu_daily/util/daily_html_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zhihu_daily/blocs/detail_bloc.dart';

class DetailPage extends StatefulWidget {
  final int id;

  const DetailPage({Key key, this.id}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (BuildContext context){
        return DetailBloc();
      },
      child: Builder(builder: (context){
        DetailBloc _detailBloc=BlocProvider.of<DetailBloc>(context);
        return BlocListener<DetailEvent,DetailState>(
          bloc: _detailBloc,
          listener: (_,state){
            if(state.status==DataStatus.init){
              _detailBloc?.dispatch(GetDetailEvent(widget.id));
            }else if(state.status==DataStatus.complete
                &&state.webViewStatus==WebViewStatus.created){
              _loadWebViewData(state.detail);
              _detailBloc?.dispatch(WebViewStatusEvent(WebViewStatus.loaded));
            }
          },
          child: Scaffold(
              appBar: buildAppBar(context),
              body: Builder(builder: buildContent)
          ),
        );
      }),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.share),
            onPressed: () {

            }),
        IconButton(
            icon: Icon(Icons.star),
            onPressed: () {

            }),
        IconButton(
            icon: Icon(Icons.sms),
            onPressed: () {

            }),
        IconButton(
            icon: Icon(IconFontData.like),
            onPressed: () {

            }),
      ],
    );
  }

  Widget buildContent(BuildContext context){
    final bloc = BlocProvider.of<DetailBloc>(context);
    final Widget webView=WebView(
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller){
        _webViewController=controller;
        bloc.dispatch(WebViewStatusEvent(WebViewStatus.created));
      }
    );
    return BlocBuilder<DetailEvent,DetailState>(
        bloc: bloc,
        builder: (_,state){
          //WebView初始化时会黑屏，用IndexedStack控制显示
          //只有当WebView加载和数据请求都完成后才显示
          return IndexedStack(
            children: <Widget>[
              Builder(builder: (context){
                if(state.status==DataStatus.loading||
                    state.webViewStatus==WebViewStatus.init){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }else if(state.status==DataStatus.error){
                  return Center(
                    child: Text("加载失败"),
                  );
                }else{
                  return Container();
                }
              }),
              webView
            ],
            index: state.status==DataStatus.complete
                &&state.webViewStatus!=WebViewStatus.init
                ?1:0,
          );


        }
    );
  }

  void _loadWebViewData(Detail detail){
    if(detail==null) return;
    _webViewController?.loadUrl(
        Uri.dataFromString(
            parseDetailHtml(detail),
            encoding: Encoding.getByName("utf-8"),
            mimeType: "text/html"
        ).toString()
    );
  }

}

