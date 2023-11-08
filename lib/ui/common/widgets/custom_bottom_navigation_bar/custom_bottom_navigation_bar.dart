import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_station/application/bloc/custom_bottom_navigation/custom_bottom_navigation_bloc.dart';
import 'package:radio_station/ui/screens/favorite_screen/favorite_screen.dart';
import 'package:radio_station/ui/screens/home_screen/home_screen.dart';
import 'package:radio_station/ui/screens/search_screen/search_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final PageScreen pageScreen;

  const CustomBottomNavigationBar({
    super.key,
    this.pageScreen = PageScreen.home,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final CustomBottomNavigationBloc _customBottomNavigationBloc =
      GetIt.instance.get<CustomBottomNavigationBloc>();

  final List<Map<String, dynamic>> _pages = [
    {
      "enum": PageScreen.home,
      "child": const HomeScreen(),
    },
    {
      "enum": PageScreen.search,
      "child": const SearchScreen(),
    },
    {
      "enum": PageScreen.favorites,
      "child": const FavoriteScreen(),
    },
  ];

  void _onItemTapped(int index) {
    _customBottomNavigationBloc.add(LoadPageScreen(
      pageScreen: _pages[index]["enum"],
      child: _pages[index]["child"],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
      currentIndex: widget.pageScreen.value,
      unselectedItemColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: const Color(0xFFF5897F),
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
