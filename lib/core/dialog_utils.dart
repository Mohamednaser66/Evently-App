import 'package:evently/core/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static showLoadingDialog(String? message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Row(
            children: [
              Text(message ?? ''),
              Spacer(),
              CircularProgressIndicator(color: AppColors.blue),
            ],
          ),
        );
      },
    );
  }

  static hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showDialogMessage(
    BuildContext context, {
    required String message,
    String? posActionTitle,
    String? negActionTitle,
    VoidCallback? negAction,
    VoidCallback? posAction   
  }) {
    List<Widget> actions = [];
    if(negActionTitle!=null){
      actions.add(TextButton(
          onPressed: (){
            Navigator.pop(context);
            negAction?.call();

          }
          , child: Text(negActionTitle)));
    }if(posActionTitle!=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        posAction?.call();

      }, child: Text(posActionTitle)));
    }
    showDialog(
      context: context,
      builder: (context) {
     return   CupertinoAlertDialog(content: Text(message), actions: actions);
      }
    );
  }
}
