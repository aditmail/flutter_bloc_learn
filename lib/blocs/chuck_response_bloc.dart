import 'dart:async';

import 'package:streamchucknorris/models/chuck_response.dart';
import 'package:streamchucknorris/networking/api_response.dart';
import 'package:streamchucknorris/repository/chuck_response_repository.dart';

class ChuckResponseBloc {
  ChuckRepository _chuckRepository;
  StreamController _chukDataController;

  StreamSink<Response<ChuckResponse>> get chuckDataSink =>
      _chukDataController.sink;

  Stream<Response<ChuckResponse>> get chuckDataStream =>
      _chukDataController.stream;

  ChuckResponseBloc(String category) {
    _chukDataController = StreamController<Response<ChuckResponse>>();
    _chuckRepository = ChuckRepository();
    fetchChuckyJoke(category);
  }

  fetchChuckyJoke(String category) async {
    chuckDataSink.add(Response.loading('Getting Chucky Jokes'));
    try {
      ChuckResponse chuckResponse =
          await _chuckRepository.fetchChuckJoke(category);
      chuckDataSink.add(Response.completed(chuckResponse));
    } catch (e) {
      chuckDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _chukDataController?.close();
  }
}
