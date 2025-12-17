import 'package:evently/DM/firebas_services/firebase_service.dart';
import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/authentication/widgets/custom_text_button.dart';
import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/core/app_assets.dart';
import 'package:evently/core/dialog_utils.dart';
import 'package:evently/core/routes_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  bool passwordSecure = true;
  bool rePasswordSecure = true;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController rePasswordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.register)),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Image.asset(AppAssets.logo, height: 186.h, width: 136.w),
            SizedBox(height: 20.h),
            CustomTextFormField(
              controller: nameController,
              label: AppLocalizations.of(context)!.name,
              prefixIcon: Icons.person,
            ),
            CustomTextFormField(
              controller: emailController,
              label: AppLocalizations.of(context)!.email,
              prefixIcon: Icons.email,
            ),
            CustomTextFormField(
              controller: passwordController,
              label: AppLocalizations.of(context)!.password,
              prefixIcon: Icons.lock,
              suffixIcon:
                  widget.passwordSecure
                      ? Icons.visibility_off
                      : Icons.visibility,
              isSecure: widget.passwordSecure,
              onClick: () {
                widget.passwordSecure = !widget.passwordSecure;
                setState(() {});
              },
            ),
            CustomTextFormField(
              controller: rePasswordController,
              label: AppLocalizations.of(context)!.re_password,
              prefixIcon: Icons.lock,
              suffixIcon:
                  widget.rePasswordSecure
                      ? Icons.visibility_off
                      : Icons.visibility,
              isSecure: widget.rePasswordSecure,
              onClick: () {
                widget.rePasswordSecure = !widget.rePasswordSecure;
                setState(() {});
              },
            ),
            CustomElevatedButton(
              tittle: AppLocalizations.of(context)!.create_account,
              onClick: _createAccount,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.already_have_account,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                CustomTextButton(
                  tittle: AppLocalizations.of(context)!.login,
                  onClick: () {
                    Navigator.pushReplacementNamed(context, RoutesManager.signIn);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _createAccount() async {
    Dialogs.showLoadingDialog("wait", context);
    try {
      await FirebaseService.register(
        passwordController.text,
        emailController.text,
        nameController.text
      );
      Dialogs.hideDialog(context);
      Dialogs.showDialogMessage(
        context,
        message: "successfully registration",
        posActionTitle: "ok",
        posAction: () {
          Navigator.pushReplacementNamed(context, RoutesManager.signIn);
        },
      );
    } on FirebaseAuthException catch (e) {
      Dialogs.hideDialog(context);
      if (e.code == 'weak-password') {
        Dialogs.showDialogMessage(
          context,
          message: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        Dialogs.showDialogMessage(
          context,
          message: 'The account already exists for that email.',
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
