class Recipe {
  final int id;
  final String title;
  final String image;
  final String imageType;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.imageType,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      imageType: json['imageType'],
    );
  }
}

class RecipeResponse {
  final List<Recipe> results;
  final int offset;
  final int number;
  final int totalResults;

  RecipeResponse({
    required this.results,
    required this.offset,
    required this.number,
    required this.totalResults,
  });

  factory RecipeResponse.fromJson(Map<String, dynamic> json) {
    return RecipeResponse(
      results: (json['results'] as List)
          .map((recipeJson) => Recipe.fromJson(recipeJson))
          .toList(),
      offset: json['offset'],
      number: json['number'],
      totalResults: json['totalResults'],
    );
  }
}
