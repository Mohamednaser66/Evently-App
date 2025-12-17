import 'package:evently/core/app_assets.dart';

import 'package:evently/core/routes_manager.dart';
import 'package:evently/persentation/main_lay_out/tabs/home/home.dart';
import 'package:evently/persentation/main_lay_out/tabs/love/love.dart';
import 'package:evently/persentation/main_lay_out/tabs/map/maps.dart';
import 'package:evently/persentation/main_lay_out/tabs/profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainLayOut extends StatefulWidget {
  const MainLayOut({super.key});

  @override
  State<MainLayOut> createState() => _MainLayOutState();
}

class _MainLayOutState extends State<MainLayOut> {
  int newIndex=0;
  List<Widget> tabs =[Home(),Maps(),Love(),Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(onPressed: _create,child: Icon(Icons.add,),
       ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[newIndex],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 4,
        child: BottomNavigationBar(
          currentIndex: newIndex,
            onTap: (newSelectedIndex){
            setState(() {
                newIndex=newSelectedIndex;
              });
            },
            items: [
          BottomNavigationBarItem(activeIcon: SvgPicture.asset(SvgAssets.selectedHome),
              icon: SvgPicture.asset(SvgAssets.home),label: AppLocalizations.of(context)!.home),
          BottomNavigationBarItem(activeIcon:  SvgPicture.asset(SvgAssets.selectedMap),
              icon: SvgPicture.asset(SvgAssets.map),label: AppLocalizations.of(context)!.map),
          BottomNavigationBarItem(activeIcon:  SvgPicture.asset(SvgAssets.selectedHeart),
              icon: SvgPicture.asset(SvgAssets.heart),label: AppLocalizations.of(context)!.like),
          BottomNavigationBarItem(activeIcon:  SvgPicture.asset(SvgAssets.selectedPerson),
              icon: SvgPicture.asset(SvgAssets.person),label: AppLocalizations.of(context)!.profile),
        
        ]),
      ),
    );
  }
void _create(){
    Navigator.pushNamed(context, RoutesManager.createEvent);
}

}