import 'dart:async';

import 'package:streamchucknorris/models/chuck_categories.dart';
import 'package:streamchucknorris/networking/api_response.dart';
import 'package:streamchucknorris/repository/chuck_categories_repository.dart';

class ChuckCategoryBloc {
  ChuckCategoryRepository _chuckCategoryRepository;
  StreamController _chuckListController;

  //Sink? Loading Data...
  StreamSink<Response<ChuckCategories>> get chuckListSink =>
      _chuckListController.sink;

  //Response?
  Stream<Response<ChuckCategories>> get chuckListStream =>
      _chuckListController.stream;

  //Initiate
  ChuckCategoryBloc() {
    _chuckListController = StreamController<Response<ChuckCategories>>();
    _chuckCategoryRepository = ChuckCategoryRepository();
    fetchCategories();
  }

  //Load API From Chuck Categories Repo
  fetchCategories() async {
    chuckListSink.add(Response.loading('Getting Chuck Categories'));
    try {
      ChuckCategories chuckCategories = await _chuckCategoryRepository
          .fetchChuckCategoryData();
      chuckListSink.add(Response.completed(chuckCategories));
    }catch(e){
      chuckListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose(){
    _chuckListController?.close();
  }
}
