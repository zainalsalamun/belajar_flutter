import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterEvent { increment, decrement }

class CounterState {
  final int counter;
  CounterState({required this.counter});
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(counter: 0)) {
    on<CounterEvent>((event, emit) {
      if (event == CounterEvent.increment) {
        emit(CounterState(counter: state.counter + 1));
      } else if (event == CounterEvent.decrement) {
        emit(CounterState(counter: state.counter - 1));
      }
    });
  }
}
