import 'package:evently/DM/event_data.dart';
import 'package:evently/core/app_assets.dart';
import 'package:evently/core/app_colors.dart';
import 'package:evently/persentation/main_lay_out/tabs/home/widget/event_date.dart';
import 'package:evently/persentation/main_lay_out/tabs/home/widget/event_tittle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventComponent extends StatelessWidget {
  const EventComponent({super.key, required this.eventData,this.isFav =false});
 final EventData eventData;
final isFav;
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: REdgeInsets.all(8),
      margin: REdgeInsets.symmetric(horizontal: 16,vertical: 8),

      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(eventData.category.imagePath??'assets/images/birthday.png'),fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(16.r),
        border: Border.all(width: 2,color: AppColors.blue)
      ),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        EventDate(date: eventData.date),
          SizedBox(height: 96.h,),
          EventTitle(title: eventData.tittle, eventId: eventData.id,isFav: isFav,)
        ],
      ),
    );
  }
}
