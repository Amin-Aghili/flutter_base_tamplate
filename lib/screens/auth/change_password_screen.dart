import 'package:flutter/material.dart';
import 'package:flutter_base_template/ui/components/my_button.dart';
import 'package:flutter_base_template/ui/components/my_text_field.dart';

import '../../l10n/app_localizations.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void changePassword() {
      // Logic to reset the password
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.resetPassword),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 400,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.resetPassword,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: AppLocalizations.of(context)!.currentPassword,
              ),
              SizedBox(height: 8),
              MyTextField(
                controller: newPasswordController,
                hintText: AppLocalizations.of(context)!.newPassword,
              ),
              SizedBox(height: 8),
              MyTextField(
                controller: confirmPasswordController,
                hintText: AppLocalizations.of(context)!.confirmPassword,
              ),
              SizedBox(height: 20),
              MyButton(
                text: AppLocalizations.of(context)!.reset,
                onTap: changePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
