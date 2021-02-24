part of 'sets_bloc.dart';

@immutable
abstract class SetsState {}

class SetsInitial extends SetsState {}

class CreatingSetState extends SetsState {}

class SetsDataState extends SetsState {}
