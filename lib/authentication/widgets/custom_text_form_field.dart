import 'package:evently/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
     this.label,
     this.prefixIcon,
    this.suffixIcon,
    this.isSecure = false,
    this.onClick, this.hint,  this.lines=1,
    this.controller,
    this.validator
  });
  final int lines;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isSecure;
 final VoidCallback? onClick;
 final TextEditingController? controller;
 final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: validator,
          controller:controller ,
          maxLines: lines,
          style: Theme.of(context).textTheme.displaySmall,
          cursorColor: AppColors.black,
          obscureText: isSecure,
          decoration: InputDecoration(
            hintText: hint,
            labelText: label,
            prefixIcon: prefixIcon!=null?Icon(prefixIcon):null,
            suffixIcon: IconButton(onPressed: onClick, icon: Icon(suffixIcon)),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
