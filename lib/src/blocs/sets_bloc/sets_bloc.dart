import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/model/domain/domian.dart';

part 'sets_event.dart';
part 'sets_state.dart';

class SetsBloc extends Bloc<SetsEvent, SetsState> {
  SetsBloc() : super(SetsInitial());

  final List<VCCSSet> sets = [];

  @override
  Stream<SetsState> mapEventToState(
    SetsEvent event,
  ) async* {
    switch (event.runtimeType) {
      case CreateSetEvent:
        break;
      case DeleteSetEvent:
        break;
      case LoadSetsEvent:
        break;
    }
  }
}
