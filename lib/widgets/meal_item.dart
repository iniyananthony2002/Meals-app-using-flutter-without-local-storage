import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:meals/widgets/meal_item_trait.dart';
import 'package:meals/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.imageUrl,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),

            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // Very long text ...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                          color: Colors.white,
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                          // color: Colors.green.shade700,
                          color: affordabilityText == 'Affordable' ? Colors.green.shade700 : affordabilityText == 'Pricey' ? Colors.orange.shade700 : Colors.purple.shade300,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReverseMealItemTrait(
                          icon: meal.isGlutenFree ? Icons.check : Icons.close,
                          label: 'Gluten-free',
                          color: meal.isGlutenFree ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 12),
                        ReverseMealItemTrait(
                          icon: meal.isLactoseFree ? Icons.check : Icons.close,
                          label: 'Lactose-free',
                          color: meal.isLactoseFree ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 12),
                        ReverseMealItemTrait(
                          icon: meal.isVegetarian ? Icons.check : Icons.close,
                          label: 'vegitarian',
                          color: meal.isVegetarian ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 12),
                        ReverseMealItemTrait(
                          icon: meal.isVegan ? Icons.check : Icons.close,
                          label: 'Vegan',
                          color: meal.isVegan ? Colors.green : Colors.red,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}