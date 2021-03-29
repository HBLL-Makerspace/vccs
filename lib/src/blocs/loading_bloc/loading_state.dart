part of 'loading_bloc.dart';

@immutable
abstract class LoadingState {}

class LoadingDataState extends LoadingState {
  final String loading;
  final double percent;

  LoadingDataState(this.loading, this.percent);
}

class LoadingFinished extends LoadingState {}

class LoadingIgnore extends LoadingState {}
