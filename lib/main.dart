import 'package:flutter/material.dart';
import 'package:flutter_zhihu_daily/blocs/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'page/home_page.dart';
import 'package:flutter_zhihu_daily/util/sp_util.dart';

void main()async{
  SpUtil spUtil=await SpUtil.getInstance();
  runApp(DailyApp(spUtil: spUtil,));
}

class DailyApp extends StatefulWidget {
  final SpUtil spUtil;

  const DailyApp({Key key,@required this.spUtil})
      : assert(spUtil!=null),
        super(key: key);

  @override
  _DailyAppState createState() => _DailyAppState();
}

class _DailyAppState extends State<DailyApp> {
  @override
  Widget build(BuildContext context) {
    final _themeBloc=ThemeBloc(widget.spUtil);
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<ThemeBloc>(builder: (_)=>_themeBloc,),
        BlocProvider<SettingsBloc>(builder: (_)=>SettingsBloc(),),
      ],
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (_, ThemeState themeState) {
          return MaterialApp(
            title: 'Flutter知乎日报',
            theme: themeState.theme,
            home: HomePage(),
          );
        },
      ),
    );
  }
}