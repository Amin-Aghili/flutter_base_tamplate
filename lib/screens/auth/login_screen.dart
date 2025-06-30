import 'package:flutter/material.dart';
import 'package:flutter_base_template/screens/auth/forgot_password.dart';
import 'package:flutter_base_template/screens/main/main_screen.dart';
import 'package:flutter_base_template/services/auth_service.dart';
import 'package:flutter_base_template/services/local_storage_service.dart';
import 'package:flutter_base_template/ui/components/my_button.dart';
import 'package:flutter_base_template/responsive.dart';
import 'package:flutter_base_template/ui/components/my_text_form_field.dart';
import 'package:flutter_base_template/utils/validator.dart';

import '../../l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  final void Function() onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String? userName = LocalStorageService().getUsername();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();
  String? forceErrorText;
  bool isLoading = false;
  bool _obscurePassword = true;
  bool isTextError = false;

  @override
  void initState() {
    super.initState();

    // debug mod
    // emailController.text = "admin2";
    // passwordController.text = "1234";
  }

  Future<void> navigateToMainScreen() async {
    if (mounted) {
      await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false,
      );
    }
  }

  Future<void> login() async {
    final bool isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      setState(() {
        isTextError = true;
      });
      return;
    }

    setState(() => isLoading = true);
    // final String? errorText = await validateUsernameFromServer(controller.text);

    if (context.mounted) {
      // setState(() => isLoading = false);
      // TODO
      // https://api.flutter.dev/flutter/material/TextFormField-class.html

      // if (errorText != null) {
      //   setState(() {
      //     forceErrorText = errorText;
      //   });
      // }
    }
    // setState(() {
    //   isLoading = true;
    // });

    final email = emailController.text;
    final password = passwordController.text;

    try {
      final isSuccess = await _authService.login(email, password);
      if (isSuccess) {
        await navigateToMainScreen();
      } else {
        _showError('Login failed. Please check your credentials.');
      }
    } catch (e) {
      _showError('An error occurred during login. Please try again.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void onChanged(String value) {
    // Nullify forceErrorText if the input changed.
    if (forceErrorText != null) {
      setState(() {
        forceErrorText = null;
        isTextError = false;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Form(
              key: formKey,
              autovalidateMode:
                  (isTextError) ? AutovalidateMode.onUserInteraction : null,
              child: Container(
                width: (!Responsive.isMobile(context)) ? 400 : null,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: (!Responsive.isMobile(context))
                        ? MainAxisSize.min
                        : MainAxisSize.max,
                    children: [
                      const SizedBox(height: 20),
                      Icon(
                        Icons.lock_clock_rounded,
                        size: (Responsive.isMobile(context)) ? 50 : 100,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      SizedBox(
                          height: (Responsive.isMobile(context)) ? 20 : 40),
                      Text(
                        AppLocalizations.of(context)!.login,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: (Responsive.isMobile(context)) ? 5 : 20),
                      MyTextFormField(
                        forceErrorText: forceErrorText,
                        onChanged: onChanged,
                        validator: usernameValidator,
                        controller: emailController,
                        hintText: AppLocalizations.of(context)!.email,
                      ),
                      SizedBox(
                          height: (Responsive.isMobile(context)) ? 10 : 20),
                      MyTextFormField(
                        forceErrorText: forceErrorText,
                        onChanged: onChanged,
                        validator: passwordValidator,
                        controller: passwordController,
                        hintText: AppLocalizations.of(context)!.password,
                        obscureText: _obscurePassword,
                        onTapSuffix: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        suffixIcon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      SizedBox(
                          height: (Responsive.isMobile(context)) ? 10 : 25),
                      isLoading
                          ? const CircularProgressIndicator()
                          : MyButton(
                              text: AppLocalizations.of(context)!.login,
                              onTap: login,
                            ),
                      SizedBox(
                          height: (Responsive.isMobile(context)) ? 15 : 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.goRegister),
                          TextButton(
                            onPressed: widget.onTap,
                            child: Text(AppLocalizations.of(context)!.register),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child:
                            Text(AppLocalizations.of(context)!.forgotPassword),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            const Opacity(
              opacity: 0.7,
              child: ModalBarrier(
                dismissible: false,
                color: Colors.black,
              ),
            ),
        ],
      ),
    );
  }
}
