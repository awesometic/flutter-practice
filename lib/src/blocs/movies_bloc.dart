import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';

class MoviesBloc {
  final _repository = Repository();

  // We are creating a PublishSubject object whose responsibility is
  // to add the data which it got from the server in the form of ItemModel object
  // and pass it to the UI screen as a stream.
  final _moviesFetcher = PublishSubject<ItemModel>();

  // Observable is deprecated in rxdart 0.23.1
  // It now relies on extension methods, to implement all of the Observable features directly on Stream
  // Or, replace it to Rx so that we can use some methods like Rx.combineLatest
  Stream<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

// This way we are giving access to a single instance of the MoviesBloc class to the UI screen.
final bloc = MoviesBloc();
