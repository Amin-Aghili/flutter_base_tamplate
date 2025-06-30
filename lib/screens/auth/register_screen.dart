import 'package:flutter/material.dart';
import 'package:flutter_base_template/responsive.dart';
import 'package:flutter_base_template/screens/main/components/language_selector.dart';
import 'package:flutter_base_template/screens/main/main_screen.dart';
import 'package:flutter_base_template/ui/components/my_button.dart';
import 'package:flutter_base_template/ui/components/my_text_field.dart';

import '../../l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  final void Function() onTap;
  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    void login() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Container(
          width: (!Responsive.isMobile(context)) ? 400 : null,
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: (!Responsive.isMobile(context))
                  ? MainAxisSize.min
                  : MainAxisSize.max,
              children: [
                LanguageSelector(),
                Icon(
                  Icons.lock_clock_rounded,
                  size: (Responsive.isMobile(context)) ? 50 : 100,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                SizedBox(height: (Responsive.isMobile(context)) ? 20 : 20),
                Text(
                  AppLocalizations.of(context)!.register,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: (Responsive.isMobile(context)) ? 10 : 20),
                MyTextField(
                  controller: emailController,
                  hintText: AppLocalizations.of(context)!.email,
                ),
                SizedBox(height: (Responsive.isMobile(context)) ? 10 : 20),
                MyTextField(
                  controller: passwordController,
                  hintText: AppLocalizations.of(context)!.password,
                ),
                SizedBox(height: (Responsive.isMobile(context)) ? 15 : 25),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: AppLocalizations.of(context)!.confirmPassword,
                ),
                SizedBox(height: (Responsive.isMobile(context)) ? 15 : 25),
                MyButton(
                  text: AppLocalizations.of(context)!.register,
                  onTap: login,
                ),
                SizedBox(height: (Responsive.isMobile(context)) ? 10 : 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.goLogin,
                    ),
                    TextButton(
                      onPressed: widget.onTap,
                      child: Text(
                        AppLocalizations.of(context)!.login,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
