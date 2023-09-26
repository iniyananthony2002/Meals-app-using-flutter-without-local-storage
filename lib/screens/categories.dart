import 'package:flutter/material.dart';

import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.glutenFreeFilter,
    required this.lactoseFreeFilter,
    required this.vegitarianFilter,
    required this.veganFilter,
  });

  final bool glutenFreeFilter;
  final bool lactoseFreeFilter;
  final bool vegitarianFilter;
  final bool veganFilter;

  void _selectCategory(BuildContext context, Category category) {
    List<Meal> filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    if (glutenFreeFilter) {
      filteredMeals = filteredMeals
          .where((meal) => meal.isGlutenFree == true)
          .toList();
    }

    if (lactoseFreeFilter) {
      filteredMeals = filteredMeals
          .where((meal) => meal.isLactoseFree == true)
          .toList();
    }

    if (vegitarianFilter) {
      filteredMeals = filteredMeals
          .where((meal) => meal.isVegetarian == true)
          .toList();
    }

    if (veganFilter) {
      filteredMeals = filteredMeals
          .where((meal) => meal.isVegan == true)
          .toList();
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          isCategoryScreen: true,
          refresh: () {},
        ),
      ),
    ); // Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
