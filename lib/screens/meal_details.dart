import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';

import 'package:meals/models/meal.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.refresh,
  });

  final Meal meal;
  final void Function() refresh;

  @override
  State<MealDetailsScreen> createState() {
    return _MealDetailsScreenState();
  }
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  void _displaySnackBar(mealTitle, content) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$mealTitle $content your favorite list'),
        duration: const Duration(seconds: 3),  
        backgroundColor: Theme.of(context).indicatorColor,
      ),
    );
  }

  void _addToFavorite(meal) {
    favorites.add(meal);
    setState(() {
      favorites;
    });
    widget.refresh();
    _displaySnackBar(meal.title, 'added to');
  }

  void _removeFromFavorite(meal) {
    favorites.remove(meal);
    setState(() {
      favorites;
    });
    widget.refresh();
    _displaySnackBar(meal.title, 'removed from');
  }

  @override
  Widget build(BuildContext context) {
    bool isFavoriteMeal = false;

    if (favorites.contains(widget.meal)) {
      isFavoriteMeal = true;
    }

    return Scaffold(
        appBar: AppBar(
          title:
              Text(widget.meal.title, maxLines: 1, overflow: TextOverflow.fade),
          actions: [
            IconButton(
              onPressed: () {
                isFavoriteMeal
                    ? _removeFromFavorite(widget.meal)
                    : _addToFavorite(widget.meal);
              },
              padding: const EdgeInsets.symmetric(horizontal: 16),
              icon: isFavoriteMeal
                  ? const Icon(Icons.star)
                  : const Icon(Icons.star_border_outlined),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: widget.meal.imageUrl,
                child: Image.network(
                  widget.meal.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final ingredient in widget.meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              const SizedBox(height: 24),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final step in widget.meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
            ],
          ),
        ));
  }
}
