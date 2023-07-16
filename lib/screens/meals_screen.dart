import 'package:flutter/material.dart';
import 'package:meals_app/screens/meal_info_screen.dart';
import 'package:meals_app/widgets/meal_card.dart';

import '../model/meal.dart';

class MealsScreen extends StatelessWidget {
  MealsScreen({
    super.key,
    required this.title,
    required this.meals,
    this.noAppBar = false,
  });
  final String title;
  final List<Meal> meals;
  final noAppBar;

  void _changeScreen(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealInfoScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Uh..ohh! No Meals to Display!!",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            "Seems like you ate all of them.",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealCard(
          meal: meals[index],
          onChangeScreen: () {
            _changeScreen(context, meals[index]);
          },
        ),
      );
    }

    // for favorites screen
    if (noAppBar) {
      return mainContent;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(title),
      ),
      body: mainContent,
    );
  }
}
