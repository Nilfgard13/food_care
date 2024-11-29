import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:food_care/services/api_services.dart';
import 'package:food_care/models/RecipeDetail.dart';

class RecipeDetailPage extends StatefulWidget {
  final int recipeId;

  const RecipeDetailPage({
    Key? key,
    required this.recipeId,
  }) : super(key: key);

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  final RecipeService _recipeService = RecipeService();
  bool _isLoading = true;
  RecipeDetail? _recipeDetail;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadRecipeDetail();
  }

  Future<void> _loadRecipeDetail() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final detail = await _recipeService.getRecipeDetail(widget.recipeId);
      setState(() {
        _recipeDetail = detail;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_recipeDetail?.title ?? 'Recipe Detail'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadRecipeDetail,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final recipe = _recipeDetail!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            recipe.image,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.timer, size: 20),
                    const SizedBox(width: 4),
                    Text('${recipe.readyInMinutes} minutes'),
                    const SizedBox(width: 16),
                    Icon(Icons.people, size: 20),
                    const SizedBox(width: 4),
                    Text('${recipe.servings} servings'),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Diet Info',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    if (recipe.vegetarian) Chip(label: Text('Vegetarian')),
                    if (recipe.vegan) Chip(label: Text('Vegan')),
                    ...recipe.diets.map((diet) => Chip(label: Text(diet))),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Ingredients',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ...recipe.extendedIngredients.map(
                  (ingredient) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '• ${ingredient.original}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Summary',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                // Replace the Text widget with Html widget
                Html(
                  data: recipe.summary,
                  style: {
                    "body": Style(
                      fontSize: FontSize(16),
                      fontFamily:
                          Theme.of(context).textTheme.bodyMedium?.fontFamily,
                    ),
                    "li": Style(
                      margin: Margins.all(8), // Menggunakan Margins.all
                    ),
                    "p": Style(
                      margin: Margins.only(
                        bottom:
                            8, // Menggunakan Margins.only untuk sisi spesifik
                      ),
                    ),
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Instructions',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                // Replace the Text widget with Html widget
                Html(
                  data: recipe.instructions,
                  style: {
                    "body": Style(
                      fontSize: FontSize(16),
                      fontFamily:
                          Theme.of(context).textTheme.bodyMedium?.fontFamily,
                    ),
                    "li": Style(
                      margin: Margins.all(8), // Menggunakan Margins.all
                    ),
                    "p": Style(
                      margin: Margins.only(
                        bottom:
                            8, // Menggunakan Margins.only untuk sisi spesifik
                      ),
                    ),
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
