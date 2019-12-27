import 'dart:async';
import 'package:english_words/english_words.dart';

class Bloc {
  final Set<WordPair> saved = Set<WordPair>();

  // Stream 생성할 때 StreamController<T>로 생성
  // broadcast() 사용 시 sink 후 snapshot을 모든 listened 객체에 보내줌
  // 사용 안 하면 한 곳이 이미 sink 된 데이터를 받으면 다른 곳에선 못 받음
  final _savedController = StreamController<Set<WordPair>>.broadcast();

  // 리턴으로 정해진 것만 하므로 함수 대신 get 사용 가능
  get savedStream => _savedController.stream;
  get addCurrentSaved => _savedController.sink;

  // Stream으로 다룰 작업을 여기에 정의, 마지막에 sink
  addToOrRemoveFromSavedList(WordPair item) {
    if (saved.contains(item)) {
      saved.remove(item);
    } else {
      saved.add(item);
    }

    // 변경된 데이터를 스트림으로 보낼 때 sink 사용
    _savedController.sink.add(saved);
  }

  dispose() {
    _savedController.close();
  }
}

var bloc = Bloc();
