import 'package:evently/DM/event_data.dart';
import 'package:evently/DM/firebas_services/firebase_service.dart';
import 'package:evently/core/app_colors.dart';
import 'package:evently/persentation/main_lay_out/tabs/home/widget/event_componant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Love extends StatefulWidget {
  const Love({super.key});

  @override
  State<Love> createState() => _LoveState();
}

class _LoveState extends State<Love> {
  List<EventData> favEvents = [];
  List<EventData> filteredEvents = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavEvents();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              onChanged: (searchKey) {
                getFilteredEvents(searchKey);
              },
              style: GoogleFonts.inter(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
              decoration: InputDecoration(
                hintText: "search",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(color: AppColors.blue),
                ),
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: AppColors.gray),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: AppColors.blue),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: AppColors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: AppColors.red),
                ),
              ),
            ),
            Expanded(
              child:
                  filteredEvents.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        itemBuilder:
                            (context, index) => EventComponent(
                              eventData: filteredEvents[index],
                              isFav: true,
                            ),
                        itemCount: filteredEvents.length,
                      ),
            ),
          ],
        ),
      ),
    );
  }

  getFavEvents() async {
    favEvents = await FirebaseService.getFavEVents();
    setState(() {
      filteredEvents = favEvents;
    });
  }

  void getFilteredEvents(String searchKey) {
    if (searchKey.trim().isEmpty) {
      filteredEvents = favEvents;

    } else {
      filteredEvents =
          favEvents
              .where(
                (event) =>
                    event.tittle.toLowerCase().contains(
                      searchKey.toLowerCase(),
                    ) ||
                    event.description.toLowerCase().contains(
                      searchKey.toLowerCase(),
                    ),
              )
              .toList();
      setState(() {});
    }
  }
}
