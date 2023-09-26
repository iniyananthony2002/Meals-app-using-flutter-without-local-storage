import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';

import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  bool _glutenFreeFilter = false;
  bool _lactoseFreeFilter = false;
  bool _vegitarianFilter = false;
  bool _veganFilter = false;

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
              builder: (ctx) => FilterScreen(
                    glutenfree: _glutenFreeFilter,
                    lactosefree: _lactoseFreeFilter,
                    vegitarian: _vegitarianFilter,
                    vegan: _veganFilter,
                  )));

      _glutenFreeFilter = result![Filter.glutenFree]!;
      _lactoseFreeFilter = result[Filter.lactoseFree]!;
      _vegitarianFilter = result[Filter.vegitarian]!;
      _veganFilter = result[Filter.vegan]!;

      setState(() {
        _glutenFreeFilter;
        _lactoseFreeFilter;
        _vegitarianFilter;
        _veganFilter;
      });
    }
  }

  void _refresh() {
    setState(() {
      favorites;
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      glutenFreeFilter: _glutenFreeFilter,
      lactoseFreeFilter: _lactoseFreeFilter,
      vegitarianFilter: _vegitarianFilter,
      veganFilter: _veganFilter,
    );
    bool isCategoryScreen = true;
    bool isFavoriteScreen = false;
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: favorites,
        isCategoryScreen: false,
        refresh: _refresh,
      );
      activePageTitle = 'Your Favorites';
      isFavoriteScreen = true;
      isCategoryScreen = false;
    }

    return Scaffold(
      drawer: MainDrawer(onSelectScreen: _setScreen),
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: isCategoryScreen
                ? const Icon(Icons.set_meal)
                : const Icon(Icons.set_meal_outlined),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: isFavoriteScreen
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border_outlined),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
