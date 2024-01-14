import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  StatusBloc() : super(StatusInitial()) {
    on<StatusEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
