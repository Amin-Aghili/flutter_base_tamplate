import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_template/utils/format.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool? autofocus;
  final bool readOnly;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final VoidCallback? onTapPrefix;
  final VoidCallback? onTapSuffix;
  final VoidCallback? onEditingComplete;
  final Function(String)? onChanged;
  final TextInputType? type;
  final TextInputAction? action;
  final FocusNode? focusNode;
  final int? maxLength;
  final int? maxLines;
  final double paddingHorizontal;
  final String? Function(String?)? validator;
  final String? forceErrorText;

  const MyTextFormField({
    super.key,
    this.forceErrorText,
    this.onTapPrefix,
    this.onTapSuffix,
    required this.controller,
    this.obscureText = false,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.type,
    this.action,
    this.focusNode,
    this.autofocus,
    this.onEditingComplete,
    this.onChanged,
    this.readOnly = false,
    this.maxLength,
    this.maxLines = 1,
    this.paddingHorizontal = 25.0,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: TextFormField(
        // forceErrorText: forceErrorText,
        minLines: 1,
        validator: validator,
        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          errorText: forceErrorText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.2,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.2,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          focusColor: Theme.of(context).colorScheme.inversePrimary,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          labelText: hintText,
          labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 12),
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary, fontSize: 12),
          prefixIcon: prefixIcon != null
              ? InkWell(
                  onTap: onTapPrefix,
                  child: prefixIcon,
                )
              : null,
          suffixIconColor: Theme.of(context).colorScheme.primary,
          prefixIconColor: Theme.of(context).colorScheme.primary,
          suffixIcon: suffixIcon != null
              ? InkWell(
                  onTap: onTapSuffix,
                  child: suffixIcon,
                )
              : null,
          counterStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary, fontSize: 10),
        ),
        textInputAction: action,
        focusNode: focusNode,
        maxLines: maxLines,
        autofocus: autofocus ?? false,
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        keyboardType: type,
        maxLength: maxLength,
        readOnly: readOnly,
        inputFormatters: type == TextInputType.number
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                ThousandsSeparatorInputFormatter(),
              ]
            : null,
      ),
    );
  }
}
