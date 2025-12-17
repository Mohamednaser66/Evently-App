import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/app_colors.dart';

class CustomProfile extends StatelessWidget {
  const CustomProfile({super.key, required this.tittle, required this.selectedText, required this.onChange, required this.listItems});
  final String tittle;
  final String selectedText;
  final void Function(String?) onChange;
  final List<String> listItems;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tittle,style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.black),),
        SizedBox(height: 16.h,),
        Container(
          padding: REdgeInsets.all(16),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(selectedText,style: Theme.of(context).textTheme.titleMedium,),
              DropdownButton<String>(
                underline: Container(),
                style: Theme.of(context).textTheme.titleSmall,
                items: listItems.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged:onChange,

              )
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Colors.transparent,
              border: Border.all(color: AppColors.blue,width: 2.w)
          ),
        )

      ],
    );
  }
}
