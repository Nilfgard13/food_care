class RecipeDetail {
  final int id;
  final String title;
  final String image;
  final int readyInMinutes;
  final int servings;
  final bool vegetarian;
  final bool vegan;
  final String summary;
  final List<String> dishTypes;
  final List<String> diets;
  final String instructions;
  final List<ExtendedIngredient> extendedIngredients;

  RecipeDetail({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
    required this.vegetarian,
    required this.vegan,
    required this.summary,
    required this.dishTypes,
    required this.diets,
    required this.instructions,
    required this.extendedIngredients,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    return RecipeDetail(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      vegetarian: json['vegetarian'],
      vegan: json['vegan'],
      summary: json['summary'],
      dishTypes: List<String>.from(json['dishTypes']),
      diets: List<String>.from(json['diets']),
      instructions: json['instructions'],
      extendedIngredients: (json['extendedIngredients'] as List)
          .map((x) => ExtendedIngredient.fromJson(x))
          .toList(),
    );
  }
}

class ExtendedIngredient {
  final int id;
  final String name;
  final String original;
  final double amount;
  final String unit;

  ExtendedIngredient({
    required this.id,
    required this.name,
    required this.original,
    required this.amount,
    required this.unit,
  });

  factory ExtendedIngredient.fromJson(Map<String, dynamic> json) {
    return ExtendedIngredient(
      id: json['id'],
      name: json['name'],
      original: json['original'],
      amount: json['amount']?.toDouble() ?? 0.0,
      unit: json['unit'],
    );
  }
}
