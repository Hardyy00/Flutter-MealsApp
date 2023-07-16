import 'package:flutter/material.dart';
import "package:meals_app/model/category.dart";

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
      {super.key, required this.category, required this.onTapChange});

  final Category category;
  final void Function() onTapChange;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapChange,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(20),
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                category.color.withOpacity(0.55),
                category.color.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Text(
            category.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          )),
    );
  }
}
