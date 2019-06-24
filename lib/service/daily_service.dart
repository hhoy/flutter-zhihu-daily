import 'package:dio/dio.dart';
import '../model/models.dart';
export '../model/models.dart';

final DailyService dailyService=DailyService();

class DailyService{
  static const String baseUrl="https://news-at.zhihu.com/";
  Dio dio;

  DailyService(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 30000,
      receiveTimeout: 30000,
    );
    dio=new Dio(options);
  }

  ///获取最新的文章列表
  Future<LatestData> getLatest(){
    return dio.get("api/4/news/latest").then((Response value){
      return LatestData.fromJson(value.data);
    });
  }

  ///获取前一天文章列表
  /// [date] 当天时间，日期格式 yyyymmdd
  Future<BeforeData> getBefore(String date){
    return dio.get("api/4/news/before/$date").then((Response value){
      return BeforeData.fromJson(value.data);
    });
  }

  ///获取内容
  Future<Detail> getDetail(int id){
    return dio.get("api/4/news/$id").then((Response value){
      return Detail.fromJson(value.data);
    });
  }
}