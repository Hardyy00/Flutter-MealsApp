import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meals_app/providers/meals_provider.dart";
import "package:meals_app/screens/filters_screen.dart";

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier()
      : super({
          Filters.isGlutenFree: false,
          Filters.isLactoseFree: false,
          Filters.onlyVegan: false,
          Filters.onlyVegetarian: false,
        });

  void setFilters(Map<Filters, bool> filters) {
    state = filters;
  }

  void setFilter(Filters filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filtersProvider);

  return meals.where(
    (meal) {
      if (filters[Filters.isGlutenFree]! && !meal.isGlutenFree) return false;

      if (filters[Filters.isLactoseFree]! && !meal.isLactoseFree) return false;

      if (filters[Filters.onlyVegan]! && !meal.isVegan) return false;

      if (filters[Filters.onlyVegetarian]! && !meal.isVegetarian) return false;

      return true;
    },
  ).toList();
});
