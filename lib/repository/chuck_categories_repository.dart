import 'package:streamchucknorris/models/chuck_categories.dart';
import 'package:streamchucknorris/networking/api_provider.dart';

class ChuckCategoryRepository{
  ApiProvider _provider = ApiProvider();

  //Calling API Categories here
  Future<ChuckCategories> fetchChuckCategoryData() async{
    final response = await _provider.get("jokes/categories");
    return ChuckCategories.fromJson(response);
  }
}