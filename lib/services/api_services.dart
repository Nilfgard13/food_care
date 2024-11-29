import 'package:http/http.dart' as http;
import 'package:food_care/models/Recipe.dart';
import 'package:food_care/models/RecipeDetail.dart';
import 'dart:convert';

class RecipeService {
  static const String baseUrl = 'https://api.spoonacular.com/recipes';
  static const String apiKey = '8e78bd4a36a24db38f2484326f462cff';

  Future<RecipeResponse> getVegetarianRecipes(
      {int offset = 0, int number = 15}) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/complexSearch?apiKey=$apiKey&diet=Vegetarian&offset=$offset&number=$number',
        ),
      );

      if (response.statusCode == 200) {
        return RecipeResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<RecipeDetail> getRecipeDetail(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$id/information?apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        return RecipeDetail.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load recipe details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
