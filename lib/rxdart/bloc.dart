import 'package:rxdart/rxdart.dart';

class RxDartCounterBloc {
  int initialCount = 0;
  BehaviorSubject<int> behaviorSubject;

  RxDartCounterBloc({this.initialCount}) {
    behaviorSubject = BehaviorSubject<int>.seeded(this.initialCount);
  }

  Stream<int> get counterObservable => behaviorSubject.stream;

  void increment() => behaviorSubject.sink.add(++initialCount);
  void decrement() => behaviorSubject.sink.add(--initialCount);
  void dispose() => behaviorSubject.close();
}
