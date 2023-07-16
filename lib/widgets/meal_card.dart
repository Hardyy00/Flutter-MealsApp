import "package:flutter/material.dart";
// import "package:meals_app/main.dart";
import "package:meals_app/model/meal.dart";
import "package:meals_app/widgets/meal_trait.dart";
import "package:transparent_image/transparent_image.dart";

class MealCard extends StatelessWidget {
  const MealCard({super.key, required this.meal, required this.onChangeScreen});

  final Meal meal;
  final void Function() onChangeScreen;

  String get complexity {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordability {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onChangeScreen,
        splashColor: Theme.of(context).colorScheme.background,
        child: Stack(
          children: [
            // to animate the Image
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(horizontal: 44, vertical: 6),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealTrait(
                          icon: Icons.work,
                          label: complexity,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealTrait(
                          icon: Icons.attach_money,
                          label: affordability,
                        ),
                      ],
                    )
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
