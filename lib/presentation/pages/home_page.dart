import 'package:flutter/material.dart';
import 'package:rickmorty/presentation/pages/home/characters/characters_page.dart';
import 'package:rickmorty/presentation/pages/home/episodes/episodes_page.dart';
import 'package:rickmorty/presentation/pages/home/location/location_page.dart';
import 'package:rickmorty/presentation/utils/colors.dart';
import '../utils/custom_animated_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int value=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    bottomNavigationBar:_bottonBar() ,
      body: IndexedStack(
        index: value,
        children: [
          CharactersPage(),
          LocationsPage(),
          EpisodesPage()
        ],
        ),
    );
  }

    Widget _bottonBar(){
    int a;
    return  CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: colorPrimary,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
       selectedIndex: value,
       onItemSelected: (index)=>{
        a=index,
        setState(() {
            value=a.toInt();
        }),
       },
      items: [
        BottomNavyBarItem(
         icon:Icon(Icons.people_alt_outlined),
         title: Text("Personajes"),
         activeColor: Colors.white,
         inactiveColor: Colors.black),
         
        BottomNavyBarItem(
         icon:Icon(Icons.pin_drop),
         title: Text("Ubicaciones"),
         activeColor: Colors.white,
         inactiveColor: Colors.black),

          BottomNavyBarItem(
          icon:Icon(Icons.play_circle),
          title: Text("Episodio"),
          activeColor: Colors.white,
          inactiveColor: Colors.black),
      ]
    );
  
  } 
}