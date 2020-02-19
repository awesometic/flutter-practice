import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/movies_bloc.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();

    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      // As I told you, our MoviesBloc class is passing the new data as a stream.
      // So to deal with streams we have a nice inbuilt class i.e StreamBuilder
      // which will listen to the incoming streams and update the UI accordingly.
      // StreamBuilder is expecting a stream parameter where we are passing
      // the MovieBloc’s allMovies() method as it is returning a stream.
      // So the moment there is a stream of data coming, StreamBuilder
      // will re-render the widget with the latest data.
      body: StreamBuilder(
        stream: bloc.allMovies,
        // Here the snapshot data is holding the ItemModel object
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
  return GridView.builder(
    itemCount: snapshot.data.results.length,
    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemBuilder: (BuildContext context, int index) {
      return Image.network(
        'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
        fit: BoxFit.cover,
      );
    },
  );
}
