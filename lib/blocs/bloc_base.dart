import 'package:equatable/equatable.dart';
export 'package:bloc/bloc.dart';
export 'dart:async';

abstract class BaseState extends Equatable {
  BaseState([List props = const []]) : super(props);
}

/*class StateHolder<Type>{
  final Type state;

  StateHolder(this.state);

  StateHolder<Type> stateChange() => StateHolder(state);
}*/

