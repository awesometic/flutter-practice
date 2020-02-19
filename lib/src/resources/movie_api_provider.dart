import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '4cb9874344ae8c923ddcaf902249d38c';

  // fetchMovieList() method is making the network call to the API.
  // Once the network call is complete it’s returning a Future ItemModel object
  // if the network call was successful or it will throw an Exception.
  Future<ItemModel> fetchMovieList() async {
    print('entered');

    final response = await client
        .get('http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey');
    print(response.body.toString());

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error
      throw Exception('Failed to load post');
    }
  }
}
