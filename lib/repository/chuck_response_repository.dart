import 'package:streamchucknorris/models/chuck_response.dart';
import 'package:streamchucknorris/networking/api_provider.dart';

class ChuckRepository {
  ApiProvider _provider = ApiProvider();

  //Calling API Detail Jokes here
  Future<ChuckResponse> fetchChuckJoke(String category) async {
    final response = await _provider.get("jokes/random?category=$category");
    return ChuckResponse.fromJson(response);
  }
}
