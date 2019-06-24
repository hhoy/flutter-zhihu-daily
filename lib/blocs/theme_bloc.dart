import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_zhihu_daily/util/sp_util.dart';

enum ThemeMode { light,dark }

class ThemeState extends Equatable {
  final ThemeData theme;
  final bool isDarkTheme;

  ThemeState({@required this.theme, @required this.isDarkTheme})
      : assert(theme != null),
        assert(isDarkTheme != null),
        super([theme, isDarkTheme]);
}

abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const []]) : super(props);
}

class ThemeToggleEvent extends ThemeEvent{}


class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SpUtil spUtil;

  ThemeBloc(this.spUtil)
      :assert(spUtil!=null);

  @override
  ThemeState get initialState {
    bool isDarkTheme=spUtil.getBool(SharedPreferencesKeys.isDarkTheme);
    return buildState(isDarkTheme);
  }

  ThemeData buildThemeData(bool isDarkTheme){
    if(isDarkTheme){
      return ThemeData.dark();
    }else{
      return ThemeData.light().copyWith(
          backgroundColor: Color(0xffF3F3F3)
      );
    }
  }

  ThemeState buildState(bool isDarkTheme)=>
      ThemeState(
        theme: buildThemeData(isDarkTheme),
        isDarkTheme: isDarkTheme
      );

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    switch(event.runtimeType){
      case ThemeToggleEvent:
        bool isDarkTheme=!currentState.isDarkTheme;
        await spUtil.setBool(SharedPreferencesKeys.isDarkTheme, isDarkTheme);
        yield buildState(isDarkTheme);
        break;
    }
  }

}
