import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:meals_app/providers/filters_provider.dart';

enum Filters { isGlutenFree, isLactoseFree, onlyVegan, onlyVegetarian }

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
        backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SwitchListTile(
            value: filters[Filters.isGlutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filters.isGlutenFree, isChecked);
            },
            title: Text(
              "Gluten-free",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              "Only Include Gluten Free Meals.",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            contentPadding: const EdgeInsets.only(left: 28, right: 25),
          ),
          SwitchListTile(
            value: filters[Filters.isLactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filters.isLactoseFree, isChecked);
            },
            title: Text(
              "Lactose-Free",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              "Only Include Lactose Free Meals",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            contentPadding: const EdgeInsets.only(left: 28, right: 25),
          ),
          SwitchListTile(
            value: filters[Filters.onlyVegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filters.onlyVegetarian, isChecked);
            },
            title: Text(
              "Only Vegetarian",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              "Only Include Vegetarian Meals",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            contentPadding: const EdgeInsets.only(left: 28, right: 25),
          ),
          SwitchListTile(
            value: filters[Filters.onlyVegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filters.onlyVegan, isChecked);
            },
            title: Text(
              "Only Vegan",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              "Only Include Vegan Meals",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            contentPadding: const EdgeInsets.only(left: 28, right: 25),
          )
        ],
      ),
    );
  }
}
