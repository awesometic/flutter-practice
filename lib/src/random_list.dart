import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'saved.dart';
import 'bloc/bloc.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("naming app"), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SavedList()));
          },
        )
      ]),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
        stream: bloc.savedStream,
        builder: (context, snapshot) {
          // Stream sink 후 데이터 변경된 사항이 snapshot이 되어 여기로 콜백됨
          return ListView.builder(itemBuilder: (context, index) {
            // 0, 2, 4, 6, 8, ... = real items
            // 1, 3, 5, 7, 9, ... = dividers
            if (index.isOdd) {
              return Divider();
            }
            var realIndex = index ~/ 2;

            if (realIndex >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
            }

            // StreamController로 만들어진 Stream 객체의 제네릭이 Set<WordPair> 이므로
            // snapshot의 data는 Set<WordPair>
            return _buildRow(snapshot.data, _suggestions[realIndex]);
          });
        });
  }

  Widget _buildRow(Set<WordPair> saved, WordPair pair) {
    // 첫 실행 시 Stream의 data는 Set<WordPair>이 아니라 아직 sink 전이라 null
    final bool alreadySaved = saved == null ? false : saved.contains(pair);

    return ListTile(
        title: Text(pair.asPascalCase, textScaleFactor: 1.5),
        trailing: alreadySaved
            ? Icon(Icons.favorite, color: Colors.pink)
            : Icon(Icons.favorite_border, color: Colors.pink),
        onTap: () {
          bloc.addToOrRemoveFromSavedList(pair);
        });
  }
}
