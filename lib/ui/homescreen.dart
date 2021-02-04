import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/util/defaultText.dart';
import 'package:flutter_app/util/helper.dart';
import 'package:flutter_app/util/ui.dart';

import 'favorite/favoritescreen.dart';
import 'klasemen/klasemenscreen.dart';
import 'match/matchscreen.dart';
import 'teams/teamsscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  int pos = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          _getPageWidget(pos),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: BottomNavigationBar(
            backgroundColor: Colors.blueGrey,
            type: BottomNavigationBarType.fixed,
            currentIndex: 0,
            onTap: (index) {
              print('page $index');

              switch (index) {
                case 0:
                  pos = 0;
                  // isOpen = false;
                  setState(() {});
                  break;
                case 1:
                  pos = 1;
                  // isOpen = false;
                  setState(() {});
                  break;
                case 2:
                  pos = 2;
                  // isOpen = false;
                  setState(() {});
                  break;
                case 3:
                  pos = 3;
                  // isOpen = false;
                  setState(() {});
                  break;
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.table_chart,
                  color: pos == 0 ? Colors.white : Colors.black38,
                ),
                title: new DefaultText(
                  textLabel: 'KLASEMEN',
                  colorsText: pos == 0 ? Colors.white : Colors.black38,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.sports_soccer_outlined,
                  color: pos == 1 ? Colors.white : Colors.black38,
                ),
                title: new DefaultText(
                  textLabel: 'MATCHES',
                  colorsText: pos == 1 ? Colors.white : Colors.black38,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_work_rounded,
                  color: pos == 2 ? Colors.white : Colors.black38,
                ),
                title: new DefaultText(
                  textLabel: 'TEAMS',
                  colorsText: pos == 2 ? Colors.white : Colors.black38,
                ),
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_outline,
                    color: pos == 3 ? Colors.white : Colors.black38,
                  ),
                  title: DefaultText(
                    textLabel: 'FAVORITES',
                    colorsText: pos == 3 ? Colors.white : Colors.black38,
                  )),
            ]),
      ),
    );
  }

  Widget _getPageWidget(int pos) {
    switch (pos) {
      case 0:
        return KlasemenScreen();
      case 1:
        return MatchesScreen();
      case 2:
        return TeamsScreen();
      case 3:
        return FavoritesScreen();

      default:
        return Container(
          child: Center(
            child: Text(''),
          ),
        );
    }
  }
}