import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favourites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import '../model/meal.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _currentIndex = 0;

  void _drawerOperations(String operation) {
    if (operation == "Filters") {
      Navigator.of(context).pop(); // pop the drawer
      Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) =>
              FiltersScreen(), // passing the current filters to make the filters maintain their state
        ),
      );
    } else {
      Navigator.of(context).pop(); // pop the drawer
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Meal> _availableMeals = ref.watch(filteredMealsProvider);

    void _changeScreen(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    Widget _currentScreen = CategoriesScreen(
      availableMeals: _availableMeals,
    );

    if (_currentIndex == 1) {
      List<Meal> favoriteMeals = ref.watch(favoriteMealsProvider);
      _currentScreen = MealsScreen(
        title: "Favorites",
        meals: favoriteMeals,
        noAppBar: true,
      );
    }

    var _currentTitle = "Pick Up a Category";
    if (_currentIndex == 1) _currentTitle = "Your Favorites";

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentTitle),
      ),
      drawer: MainDrawer(drawerOperations: _drawerOperations),
      bottomNavigationBar: BottomNavigationBar(
          unselectedFontSize: 16,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          elevation: 20,
          onTap: _changeScreen,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.set_meal,
                size: 30,
              ),
              label: "Categories",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Favorites",
            )
          ]),
      body: _currentScreen,
    );
  }
}
