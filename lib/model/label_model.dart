import 'package:date_format/date_format.dart';
import 'package:flutter_zhihu_daily/util/date_util.dart';

///时间标签
class Label{
  String date;
  Label(this.date);

  @override
  String toString() {
    var dateTime = DateTime.tryParse(date);
    if(dateTime==null) return "";
    return formatDate(dateTime, [mm, '月', dd, '日', ' ', parseWeekDay(dateTime.weekday)]);
  }

}