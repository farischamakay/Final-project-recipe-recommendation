import '../models/tambahan_bahan.dart';
import 'analyzed_instuction.dart';

class Recipe {
  int? id;
  String? title;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;
  String? image;
  String? imageType;
  String? summary;
  List<dynamic>? cuisines;
  List<dynamic>? dishTypes;
  String? instructions;
  List<AnalyzedInstruction>? analyzedInstructions;
  dynamic originalId;
  String? spoonacularSourceUrl;
  bool? vegetarian;
  bool? vegan;
  int? aggregateLikes;
  double? spoonacularScore;
  String? sourceName;
  double? pricePerServing;
  List<TambahanBahan>? extendedIngredients;

  Recipe({
    this.id,
    this.title,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
    this.image,
    this.imageType,
    this.summary,
    this.cuisines,
    this.dishTypes,
    this.instructions,
    this.analyzedInstructions,
    this.originalId,
    this.spoonacularSourceUrl,
    this.vegetarian,
    this.vegan,
    this.aggregateLikes,
    this.spoonacularScore,
    this.sourceName,
    this.pricePerServing,
    this.extendedIngredients,
  });

  factory Recipe.fromJson(json) => Recipe(
        id: json['id'] as int?,
        title: json['title'] as String?,
        readyInMinutes: json['readyInMinutes'] as int?,
        servings: json['servings'] as int?,
        sourceUrl: json['sourceUrl'] as String?,
        image: json['image'] as String?,
        imageType: json['imageType'] as String?,
        summary: json['summary'] as String?,
        cuisines: json['cuisines'] as List<dynamic>?,
        dishTypes: json['dishTypes'] as List<dynamic>?,
        instructions: json['instructions'] as String?,
        analyzedInstructions: (json['analyzedInstructions'] as List<dynamic>?)
            ?.map((e) => AnalyzedInstruction.fromJson(e))
            .toList(),
        // ignore: unnecessary_question_mark
        originalId: json['originalId'] as dynamic?,
        spoonacularSourceUrl: json['spoonacularSourceUrl'] as String?,
        vegetarian: json['vegetarian'] as bool?,
        vegan: json['vegan'] as bool?,
        aggregateLikes: json['aggregateLikes'] as int?,
        spoonacularScore: json['spoonacularScore'] as double?,
        sourceName: json['sourceName'] as String?,
        pricePerServing: (json['pricePerServing'] as num?)?.toDouble(),
        extendedIngredients: (json['extendedIngredients'] as List<dynamic>?)
            ?.map((e) => TambahanBahan.fromJson(e))
            .toList(),
      );

  toJson() => {
        'id': id,
        'title': title,
        'readyInMinutes': readyInMinutes,
        'servings': servings,
        'sourceUrl': sourceUrl,
        'image': image,
        'imageType': imageType,
        'summary': summary,
        'cuisines': cuisines,
        'dishTypes': dishTypes,
        'instructions': instructions,
        'analyzedInstructions':
            analyzedInstructions?.map((e) => e.toJson()).toList(),
        'originalId': originalId,
        'spoonacularSourceUrl': spoonacularSourceUrl,
        'vegetarian': vegetarian,
        'vegan': vegan,
        'aggregateLikes': aggregateLikes,
        'spoonacularScore': spoonacularScore,
        'sourceName': sourceName,
        'pricePerServing': pricePerServing,
        'extendedIngredients':
            extendedIngredients?.map((e) => e.toJson()).toList(),
      };
}
