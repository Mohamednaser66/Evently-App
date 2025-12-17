import 'package:evently/DM/category_dm.dart';
import 'package:evently/DM/event_data.dart';
import 'package:evently/DM/firebas_services/firebase_service.dart';
import 'package:evently/DM/user_dm.dart';
import 'package:evently/core/app_colors.dart';
import 'package:evently/core/constant_manager.dart';
import 'package:evently/core/routes_manager.dart';
import 'package:evently/persentation/main_lay_out/tabs/home/widget/custom_tab_bar.dart';
import 'package:evently/persentation/main_lay_out/tabs/home/widget/event_componant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  Home({super.key,required });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int newIndex =0;
  CategoryDM selectedCategory = ConstantManager.categoriesWithAll[0];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(right: 16, left: 16, top: 40, bottom: 16),
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .primaryColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.welcome_back,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                UserDM.currentUser!.name,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Theme
                        .of(context)
                        .colorScheme
                        .outline,
                  ),
                  Text(
                    'Cairo , Egypt',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              CustomTabBar(
                onCategoryItemClicked: (category){
                  selectedCategory = category;
                  setState(() {

                  });
                },
                categories: ConstantManager.categoriesWithAll,
                selectedTabBgColor: Theme
                    .of(context)
                    .colorScheme
                    .secondary,
                unSelectedTabBgColor: Colors.transparent,
                selectedContentColor: Theme
                    .of(context)
                    .colorScheme
                    .onSecondary,
                unSelectedContentColor: AppColors.light,
              ),
            ],
          ),
        ),
        StreamBuilder(
          stream: FirebaseService.getEventsRealTime(selectedCategory),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
             List<EventData> events = snapshot.data  ?? [];

            return Expanded(
              child: ListView.builder(
                itemBuilder:
                    (context, index) =>
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, RoutesManager.eventDetails,arguments: events[index]);
                      },
                        child: EventComponent(eventData: events[index],isFav: UserDM.currentUser!.favEventIds.contains(events[index].id),)),
                itemCount: events.length,
              ),
            );
          },
        ),
      ],
    );
  }
}