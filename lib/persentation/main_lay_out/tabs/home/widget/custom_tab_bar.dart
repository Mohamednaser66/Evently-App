import 'package:evently/DM/category_dm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    super.key,
    this.initialIndex=0,
    required this.categories,
    required this.selectedTabBgColor,
    required this.unSelectedTabBgColor,
    required this.selectedContentColor,
    required this.unSelectedContentColor,
    required this.onCategoryItemClicked

  });
 final int initialIndex;
  final List<CategoryDM> categories;
  final Color selectedTabBgColor;
  final Color unSelectedTabBgColor;
  final Color selectedContentColor;
  final Color unSelectedContentColor;
  final void Function(CategoryDM category) onCategoryItemClicked;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newIndex=widget.initialIndex;
  }
  int newIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        onTap: (selected) {
          setState(() {
            newIndex = selected;
            widget.onCategoryItemClicked(widget.categories[newIndex]);

          });
        },

        isScrollable: true,
        tabs:
            widget.categories
                .map(
                  (categoryDM) => buildTabComponent(
                    categoryDM: categoryDM,
                    isSelected: widget.categories.indexOf(categoryDM) == newIndex,
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget buildTabComponent({
    required CategoryDM categoryDM,
    required bool isSelected,
  }) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? widget.selectedTabBgColor : widget.unSelectedTabBgColor,
        borderRadius: BorderRadius.circular(46.r),
        border: Border.all(width: 2, color: widget.selectedTabBgColor),
      ),
      child: Row(
        children: [
          Icon(categoryDM.iconPath,color: isSelected ? widget.selectedContentColor : widget.unSelectedContentColor,),
          Text(
            categoryDM.name,
            style: TextStyle(
              color: isSelected ? widget.selectedContentColor : widget.unSelectedContentColor,
            ),
          ),
        ],
      ),
    );
  }
}
