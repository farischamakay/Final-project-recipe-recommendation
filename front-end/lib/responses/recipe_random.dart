import 'package:dio/dio.dart';
import '../api/api_key.dart';
import 'recipe_data.dart';
import '../models/recipe.dart';
import '../models/equipment.dart';
import '../models/similar_result.dart';
import '../models/failure.dart';

// ignore: constant_identifier_names
const RANDOM_RACIPE_PATH = '/random?number=1';

class GetRandomRecipe {
  // ignore: non_constant_identifier_names
  var key = ApiKey.keys;

  final dio = Dio();

  Future<List<dynamic>> getRecipe() async {
    var infoUrl = '$BASE_URL$RANDOM_RACIPE_PATH&apiKey=$key';
    var id = '';

    Recipe recipeInfo;
    SimilarList similarList;
    EquipmentsList equipmentList;

    final res = await dio.get(infoUrl);

    if (res.statusCode == 200) {
      recipeInfo = Recipe.fromJson(res.data['recipes'][0]);
      id = res.data['recipes'][0]['id'].toString();
    } else if (res.statusCode == 401) {
      throw Failure(code: 401, message: res.data['message']);
    } else {
      throw Failure(code: res.statusCode!, message: res.statusMessage!);
    }

    var similarUrl = '$BASE_URL$id$SIMILAR_PATH&apiKey=$key';
    var equipmentUrl = '$BASE_URL$id$EQUIPMENTS_PATH&apiKey=$key';
    var nutritionUrl = '$BASE_URL$id$NUTRITION_PATH&apiKey=$key';

    final response = await Future.wait([
      dio.get(similarUrl),
      dio.get(equipmentUrl),
      dio.get(nutritionUrl),
    ]);

    if (response[0].statusCode == 200) {
      similarList = SimilarList.fromJson(response[0].data);
    } else if (response[0].statusCode == 401) {
      throw Failure(code: 401, message: response[0].data['message']);
    } else {
      throw Failure(
          code: response[0].statusCode!, message: response[0].statusMessage!);
    }
    if (response[1].statusCode == 200) {
      equipmentList = EquipmentsList.fromJson(response[1].data['equipment']);
    } else if (response[1].statusCode == 401) {
      throw Failure(code: 401, message: response[1].data['message']);
    } else {
      throw Failure(
          code: response[1].statusCode!, message: response[1].statusMessage!);
    }

    return [
      recipeInfo,
      similarList,
      equipmentList,
    ];
  }
}
