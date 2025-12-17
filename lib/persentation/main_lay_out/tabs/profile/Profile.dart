import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/DM/firebas_services/firebase_service.dart';
import 'package:evently/DM/user_dm.dart';
import 'package:evently/core/app_assets.dart';
import 'package:evently/core/app_colors.dart';
import 'package:evently/core/routes_manager.dart';
import 'package:evently/persentation/main_lay_out/tabs/profile/widget/custom_profile.dart';
import 'package:evently/providers/config_%20provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String selectedLanguage = 'English';
  String selectedTheme = 'Light';


  @override
  Widget build(BuildContext context) {
    var configProvider =Provider.of<ConfigProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Padding(
            padding: REdgeInsets.only(bottom: 16, top: 64),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      bottomLeft: Radius.circular(1000.r),
                      bottomRight: Radius.circular(1000.r),
                      topRight: Radius.circular(1000.r),
                    ),
                    child: Image.asset(
                      AppAssets.myAsset,
                      height: 124.h,
                      width: 124.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Column(
                  children: [
                    Text(
                      UserDM.currentUser!.name,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(fontSize: 24.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      UserDM.currentUser!.email,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64.r)),
          ),
        ),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomProfile(
                tittle: AppLocalizations.of(context)!.language,
                selectedText: configProvider.isEng?'English':'عربى',
                onChange: (newLanguage) {
                  configProvider.changeAppLang(newLanguage=='English'? 'en':'ar');

                },
                listItems: ['English', 'عربى'],
              ),
              SizedBox(height: 16.h,),
              CustomProfile(tittle: AppLocalizations.of(context)!.theme,
                  selectedText: configProvider.isLight? "Light": 'Dark',
                  onChange: (newTheme){
                configProvider.changeAppTheme(newTheme=='Light' ? ThemeMode.light:ThemeMode.dark);

              },
                  listItems: ['Light','Dark']),
              SizedBox(height: 90.h,),
              SizedBox(
                height: 50.h,
                child: ElevatedButton(

                    style: ElevatedButton.styleFrom(

                  foregroundColor: AppColors.black,
                  backgroundColor: AppColors.red
                ),
                    onPressed:logOut, child: Text("LogOut")),
              )
            ],
          ),
        ),
      ],
    );
  }

  logOut()async {
 FirebaseService.logOut();
    UserDM.currentUser =null;
Navigator.pushReplacementNamed(context, RoutesManager.signIn);
  }
}
