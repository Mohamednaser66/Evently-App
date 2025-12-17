import 'package:evently/DM/category_dm.dart';
import 'package:evently/core/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConstantManager {
 static List<CategoryDM> categoriesWithAll =[
    CategoryDM(id: '1', name: 'All',iconPath: Icons.all_inclusive_outlined,),
    CategoryDM(id: '2', name: 'Sport',iconPath: Icons.sports_baseball),
    CategoryDM(id: '3', name: 'Birthday', iconPath:Icons.cake),
    CategoryDM(id: '4', name: 'Meeting', iconPath:Icons.meeting_room),
    CategoryDM(id: '5', name: 'Gaming', iconPath: Icons.gamepad_outlined),
    CategoryDM(id: '6', name: 'Eating', iconPath: Icons.fastfood),
    CategoryDM(id: '7', name: 'Holiday', iconPath: Icons.holiday_village),
    CategoryDM(id: '8', name: 'Exhibition', iconPath: Icons.water_drop_outlined),
    CategoryDM(id: '9', name: 'Workshop', iconPath: Icons.work),
    CategoryDM(id: '10', name: 'Bookshop', iconPath: Icons.book),
  ];
 static List<CategoryDM> categories =[
    CategoryDM(id: '2', name: 'Sport',imagePath: AppAssets.sports,iconPath: Icons.sports_baseball),
    CategoryDM(id: '3', name: 'Birthday', imagePath: AppAssets.birthday,iconPath:Icons.cake),
    CategoryDM(id: '4', name: 'Meeting', iconPath:Icons.meeting_room,imagePath: AppAssets.meeting),
    CategoryDM(id: '5', name: 'Gaming', iconPath: Icons.gamepad_outlined,imagePath: AppAssets.gaming),
    CategoryDM(id: '6', name: 'Eating', iconPath: Icons.fastfood,imagePath: AppAssets.eating),
    CategoryDM(id: '7', name: 'Holiday', iconPath: Icons.holiday_village,imagePath: AppAssets.holiday),
    CategoryDM(id: '8', name: 'Exhibition', iconPath:  Icons.water_drop_outlined,imagePath: AppAssets.exhibition),
    CategoryDM(id: '9', name: 'Workshop', iconPath: Icons.work,imagePath: AppAssets.workShop),
    CategoryDM(id: '10', name: 'Bookshop', iconPath:Icons.book,imagePath: AppAssets.bookClub),
 ];
}