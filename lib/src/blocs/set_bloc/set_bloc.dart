import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'set_event.dart';
part 'set_state.dart';

class SetBloc extends Bloc<SetEvent, SetState> {
  SetBloc() : super(SetInitial());

  @override
  Stream<SetState> mapEventToState(
    SetEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
