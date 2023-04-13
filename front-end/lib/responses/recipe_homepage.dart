import 'package:dio/dio.dart';
import '../api/api_key.dart';
import '../models/food_type.dart';
import 'recipe_data.dart';
import '../models/failure.dart';

class GetHomeRecipes {
  var key = ApiKey.keys;

  final dio = Dio();

  Future<FoodTypeList> getRecipes(String type, int no) async {
    var randomRecipe = '/random?number=$no&tags=$type';
    var url = '$BASE_URL$randomRecipe&apiKey=$key';
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      return FoodTypeList.fromJson(response.data['recipes']);
    } else if (response.statusCode == 401) {
      throw Failure(code: 401, message: response.data['message']);
    } else {
      throw Failure(
          code: response.statusCode!, message: response.statusMessage!);
    }
  }
}
