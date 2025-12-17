import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.tittle, required this.onClick});
  final String tittle;
 final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity.w,
      height: 50.h,
      child: ElevatedButton(

        onPressed:onClick,
        child: Text(
          tittle,

        ),
      ),
    );
  }
}
