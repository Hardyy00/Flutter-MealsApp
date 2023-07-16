import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meals_app/model/meal.dart";
import 'package:flutter/material.dart';
import "package:meals_app/providers/favourites_provider.dart";

class MealInfoScreen extends ConsumerWidget {
  const MealInfoScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favourites = ref.watch(favoriteMealsProvider);
    bool doesContain = favourites.contains(meal);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          title: Text(
            meal.title,
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
          actions: [
            IconButton(
              onPressed: () {
                bool wasAdded = ref
                    .read(favoriteMealsProvider.notifier)
                    .toggleFavoriteMeal(meal);

                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      wasAdded
                          ? "Meal has been added to the Favorites"
                          : "Meal has been removed from the Favorites",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
              icon: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: doesContain
                    ? Icon(
                        Icons.star,
                        color: Colors.yellowAccent,
                        key: ValueKey(doesContain),
                      )
                    : Icon(
                        Icons.star_border,
                        key: ValueKey(doesContain),
                      ),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: Tween<double>(begin: 0.8, end: 1).animate(animation),
                    child: child,
                  );
                },
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // to animate the image
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final ingredient in meal.ingredients)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 16,
                      ),
                ),
              ),
            const SizedBox(
              height: 18,
            ),
            Text(
              "Steps",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final ingredient in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 26),
                child: Text(
                  ingredient,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 16,
                      ),
                ),
              ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
