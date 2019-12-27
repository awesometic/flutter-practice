import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'bloc/bloc.dart';

class SavedList extends StatefulWidget {
  // 생성자
  // dart: 변수 이름 앞에 _ 가 붙으면 자동으로 private
  // 생성자에서 클래스 전역변수의 초기값을 매개변수로 받을 때
  // 이 때 pointer 값이 넘어오므로 여기서 saved Set을 만지면 이전 화면에서도 적용됨
  //  final Set<WordPair> saved;
  // SavedList({@required this.saved});
  // Stream을 사용하므로 페이지 간 이런 식의 reference 전달이 필요 없음

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved"),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
      stream: bloc.savedStream,
      builder: (context, snapshot) {
        // 첫 sink 전에는 snapshot.data 가 비어있기 때문
        // elvis 연산자 사용하면 안 됨:
        // favorite 아이콘을 누를 때 sink 되는데,
        // 화면이 넘어온 후 saved 페이지에선 snapshot이 비어 있으므로
        // addCurrentSaved 란 걸 명시적으로 만들어 sink하여 snapshot을 가져올 수 있도록 해야 함
        var saved = Set<WordPair>();

        if (snapshot.hasData) {
          saved.addAll(snapshot.data);
        } else {
          bloc.addCurrentSaved;
        }

        return ListView.builder(
            itemCount: snapshot.data.length * 2,
            itemBuilder: (context, index) {
              if (index.isOdd) {
                return Divider();
              }

              var realIndex = index ~/ 2;

              return _buildRow(snapshot.data.toList()[realIndex]);
            });
      }
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
        title: Text(pair.asPascalCase, textScaleFactor: 1.5),
        onTap: () {
          bloc.addToOrRemoveFromSavedList(pair);
        });
  }
}
