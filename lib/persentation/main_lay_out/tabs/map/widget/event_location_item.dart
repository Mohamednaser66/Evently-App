import 'package:evently/DM/event_data.dart';
import 'package:evently/core/app_assets.dart';
import 'package:evently/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventLocationItem extends StatelessWidget {
  const EventLocationItem({super.key, required this.eventData});

  final EventData eventData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,

      margin: REdgeInsets.all(6),
      padding: REdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.light,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                eventData.category.imagePath ?? AppAssets.birthday,
                fit: BoxFit.fill,
                width: double.infinity,
              height: double.infinity,),
            ),
          ),
          SizedBox(width: 6.w,),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Text(
                  eventData.description,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14.sp)
                ),
                SizedBox(height: 6.h,),
                Text(
                  '${eventData.lte},${eventData.lng}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12.sp),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
