import 'package:flutter/material.dart';
import 'package:flutter_base_template/ui/components/my_button.dart';
import 'package:flutter_base_template/ui/components/my_text_field.dart';

import '../../l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void sendResetLink() {
      // Logic to send a password reset link
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.forgotPassword),
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
                AppLocalizations.of(context)!.forgotPassword,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              MyTextField(
                controller: emailController,
                hintText: AppLocalizations.of(context)!.email,
              ),
              SizedBox(height: 20),
              MyButton(
                text: AppLocalizations.of(context)!.resetPassword,
                onTap: sendResetLink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
