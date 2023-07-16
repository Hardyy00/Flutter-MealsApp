import "package:meals_app/model/meal.dart";
import "package:riverpod/riverpod.dart";

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteNotifierState, List<Meal>>(
        (ref) => FavoriteNotifierState());

class FavoriteNotifierState extends StateNotifier<List<Meal>> {
  FavoriteNotifierState() : super([]);

  bool toggleFavoriteMeal(Meal meal) {
    bool doesContains = state.contains(meal);

    if (doesContains) {
      state = state
          .where(
            (ele) => ele.title != meal.title,
          )
          .toList();
      return false;
    } else {
      state = [...state, meal]; // create a new list , while adding the new meal
    }

    return true;
  }
}
