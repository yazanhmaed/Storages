import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.maxLines = 1,
    this.onSaved,
    required this.controller,
    required this.keyboardType,
    this.onTap,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.errorText,
    this.validate,
    this.inputFormatters,
    this.hintText,
    this.readOnly = false,
    this.enabled = true,
    this.vertical = 16,
  });
  final FormFieldValidator<String>? validate;
  final double vertical;
  final bool obscureText;
  final String label;
  final String? errorText;
  final String? hintText;
  final Function()? onTap;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        enabled: enabled,
        readOnly: readOnly!,
        obscureText: obscureText,
        textInputAction: TextInputAction.next,
        obscuringCharacter: "*",
        onTap: onTap,
        keyboardType: keyboardType,
        controller: controller,
        onSaved: onSaved,
        validator: validate,
        maxLines: maxLines,
        maxLength: maxLength,

        cursorColor: Colors.black,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: vertical),
            errorText: errorText,
            isDense: true, //بتصغر الحجم
            prefixIcon: prefixIcon,
            prefixIconColor: Colors.amber,
            suffixIcon: suffixIcon,
            hintText: hintText,
            label: Text(label),
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            disabledBorder:
                buildBorder(Theme.of(context).colorScheme.onPrimary),
            enabledBorder: buildBorder(Theme.of(context).colorScheme.primary),
            focusedBorder: buildBorder(Colors.grey),
            errorBorder: buildBorder(Theme.of(context).colorScheme.error),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.2)),
        inputFormatters: inputFormatters,
        // textCapitalization: TextCapitalization.words ,      الحروف كبتل
      ),
    );
  }

  OutlineInputBorder buildBorder([Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: color ?? Colors.white),
    );
  }
}
