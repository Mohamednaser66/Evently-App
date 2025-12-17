import 'package:evently/DM/event_data.dart';
import 'package:evently/DM/firebas_services/firebase_service.dart';
import 'package:evently/DM/user_dm.dart';
import 'package:evently/core/app_colors.dart';
import 'package:evently/core/extintions/extintion_date.dart';
import 'package:evently/core/routes_manager.dart';
import 'package:evently/persentation/event_details/widget/location_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key, required this.eventData});

  final EventData eventData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        actions: eventData.uId==UserDM.currentUser!.id?[
          IconButton(onPressed: () {
            Navigator.pushNamed(context, RoutesManager.createEvent,arguments: eventData);
          }, icon: Icon(Icons.edit)),
          IconButton(
            onPressed: () {
              FirebaseService.deleteEvent(eventData.id).then( (value) {
                Navigator.pop(context);
              },);
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ]:[],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(eventData.category.imagePath!),
          ),
          SizedBox(height: 10.h),
          Text(
            eventData.tittle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          Container(
            padding: REdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.calendar_month, color: AppColors.blue, size: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventData.date.toFormatDate,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(eventData.date.toFormatTime),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 1,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 14.h),
          LocationItem(late: eventData.lte ?? 0, lng: eventData.lng ?? 0),
          SizedBox(height: 16.h,),
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.blue,width: 1)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: GoogleMap(
                zoomControlsEnabled: true,

                scrollGesturesEnabled: false,
                markers: {
                  Marker(
                    markerId: MarkerId('2'),
                    position: LatLng(eventData.lte??0, eventData.lng??0)
                  )
                },
                initialCameraPosition: CameraPosition(
                  zoom: 17,
                  target: LatLng(eventData.lte ?? 0, eventData.lng ?? 0),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h,),
          Text('description',style: Theme.of(context).textTheme.labelSmall,),
          SizedBox(height: 8.h,),
          Text(eventData.description,style: Theme.of(context).textTheme.labelSmall,)
        ],
      ),
    );
  }
}
