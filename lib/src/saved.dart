import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class SavedList extends StatefulWidget {
  final Set<WordPair> saved;

  // 생성자
  // dart: 변수 이름 앞에 _ 가 붙으면 자동으로 private
  // 생성자에서 클래스 전역변수의 초기값을 매개변수로 받을 때
  // 이 때 pointer 값이 넘어오므로 여기서 saved Set을 만지면 이전 화면에서도 적용됨
  SavedList({@required this.saved});

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
    return ListView.builder(
        itemCount: widget.saved.length * 2,
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider();
          }

          var realIndex = index ~/ 2;

          return _buildRow(widget.saved.toList()[realIndex]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
        title: Text(pair.asPascalCase, textScaleFactor: 1.5),
        onTap: () {
          setState(() {
            widget.saved.remove(pair);
          });
        });
  }
}
