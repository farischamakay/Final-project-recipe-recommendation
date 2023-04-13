import 'package:bottom_nav_bar/persistent-tab-view.dart';
import 'package:cooking_tutorial_application/screens/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home/bloc/homepage_recipe_bloc.dart';
import '../home/homepage.dart';
import '../favorite/favorite_page.dart';
import '../profile/profile_page.dart';
import '../search/cubit/search_cubit.dart';
import '../search/search_page.dart';

class BottomNavigatorView extends StatefulWidget {
  static const nameRoute = '/bottomnav';
  const BottomNavigatorView({super.key});

  @override
  State<BottomNavigatorView> createState() => _BottomNavigatorViewState();
}

class _BottomNavigatorViewState extends State<BottomNavigatorView> {
  late PersistentTabController _controller;

  final List<Widget> _widgetOptions = <Widget>[
    const Homepage(),
    BlocProvider(
      create: (context) => SearchCubit(),
      child: const SearchPage(),
    ),
    const FavoriteScreen(),
    const ProfilePage(),
  ];
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        iconSize: 20,
        icon: const Icon(
          Icons.home,
        ),
        activeColorPrimary: Colors.redAccent,
        title: ("Home"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        iconSize: 20,
        icon: const Icon(
          Icons.search,
        ),
        activeColorPrimary: Colors.redAccent,
        title: ("Search"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        icon: const Icon(
          Icons.favorite_border,
        ),
        iconSize: 20,
        activeColorPrimary: Colors.redAccent,
        title: ("Favorite"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        icon: const Icon(
          Icons.person,
        ),
        iconSize: 20,
        activeColorPrimary: Colors.redAccent,
        title: ("Profile"),
      ),
    ];
  }

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PersistentTabView(
        this.context,
        controller: _controller,
        screens: _widgetOptions,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
