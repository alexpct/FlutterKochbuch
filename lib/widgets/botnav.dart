//Alex was here  ///
import 'package:flutter/material.dart';

import '../helper/navi.dart';


class BotNav extends StatefulWidget {
  const BotNav ({Key key,   this.index }) : super(key: key);
  final int index;
  @override
  State<BotNav> createState() => _BotNav(cIndex: index);
}
  class _BotNav extends State<BotNav> {

   _BotNav ({ this.cIndex });
  final int cIndex;
  @override
  Widget build(BuildContext context){
    void onTabTapped(int index) {
      switch (index){
        case 0:navi(context,0,""); break ;
        case 1: navi(context,1,"") ; break ;
        case 2:  navi(context,2,"") ; break ;
      }
    }
    return (
        BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: cIndex, 
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Hinzufügen",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: "Kategorie",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Verwalten",
            )
          ],
        )
    );
  }

}
