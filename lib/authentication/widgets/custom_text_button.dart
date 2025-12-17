import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.tittle, required this.onClick});
  final String tittle;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return   TextButton(
      onPressed:onClick,
      child: Text(
        tittle,

      ),
    );
  }
}
