import 'package:rxdart/rxdart.dart';

class CounterBloc {
  int initialCount = 0;
  BehaviorSubject<int> _subjectCounter;

  CounterBloc({this.initialCount}) {
    _subjectCounter = BehaviorSubject<int>.seeded(this.initialCount);
  }

  Stream<int> get counterObservable => _subjectCounter.stream;

  void increment() {
    _subjectCounter.sink.add(++initialCount);
  }

  void decrement() {
    _subjectCounter.sink.add(--initialCount);
  }

  void dispose() {
    _subjectCounter.close();
  }
}
