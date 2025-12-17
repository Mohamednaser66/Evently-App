import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/DM/firebas_services/firebase_service.dart';
import 'package:evently/DM/user_dm.dart';
import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/authentication/widgets/custom_text_button.dart';
import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/core/app_assets.dart';
import 'package:evently/core/app_colors.dart';
import 'package:evently/core/dialog_utils.dart';
import 'package:evently/core/routes_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool isSecure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController=TextEditingController();
    passwordController=TextEditingController();
    navigate();
  }
  navigate()async{
   if(FirebaseAuth.instance.currentUser !=null){
     UserDM.currentUser= await FirebaseService.getUserFromFireStore(FirebaseAuth.instance.currentUser!.uid);
     Navigator.pushReplacementNamed(context, RoutesManager.mainLayOut);
   }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Image.asset(AppAssets.logo, width: 130.w, height: 140.h),
              SizedBox(height: 24.h),
              CustomTextFormField(
                controller: emailController,
                  label: AppLocalizations.of(context)!.email,
                  prefixIcon: Icons.email),
              CustomTextFormField(
                controller: passwordController,
                label:  AppLocalizations.of(context)!.password,
                prefixIcon: Icons.lock,
                suffixIcon: isSecure ? Icons.visibility_off : Icons.visibility,
                isSecure: isSecure,
                onClick: onclick,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [CustomTextButton(tittle:  AppLocalizations.of(context)!.forget_password,onClick: (){
                 FirebaseService.resetPassword(emailController.text);
                },)],
              ),
              CustomElevatedButton(tittle:  AppLocalizations.of(context)!.login,onClick: _login,),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dont_have_account,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  CustomTextButton(tittle:  AppLocalizations.of(context)!.create_account,onClick: (){
                    Navigator.pushReplacementNamed(context, RoutesManager.signUp);
                  },),
                ],
              ),
              SizedBox(height: 10.h,),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    width: double.infinity,
                    height: 2.h,
                    color: AppColors.blue,
                  ),
                  Container(
                    color: AppColors.light,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      AppLocalizations.of(context)!.or,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: AppColors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h,),
              InkWell(
                onTap: (){
                  loginWithGoogle();
                },
                child: Container(
                  padding: REdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.google,height: 26.h,width: 26.w,),
                      Text(AppLocalizations.of(context)!.login_with_google,style: Theme.of(context).textTheme.titleMedium,)
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.blue,width: 1.w)

                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onclick() {
    isSecure = !isSecure;
    setState(() {});
  }

  void _login()async {
   await FirebaseService.login(emailController.text, passwordController.text);
    Navigator.pushReplacementNamed(context, RoutesManager.mainLayOut);
  }
  void loginWithGoogle()async{
    try{
     await FirebaseService.signInWithGoogle();
     Dialogs.showDialogMessage(context, message: 'User logged in successful ',posActionTitle: 'ok',posAction:
     (){
       Navigator.pushReplacementNamed(context, RoutesManager.mainLayOut);
     });
    } on FirebaseAuthException catch (e) {
      if(e.code== 'invalid-credential'){
        Dialogs.showDialogMessage(context, message: 'wrong email or password',negActionTitle: 'retry',);
      }

    }
  }
}

