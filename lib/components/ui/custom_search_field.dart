import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onPressed;
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  const CustomSearchField({
    super.key,
    this.validator,
    required this.onChanged,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear_rounded),
          onPressed: onPressed,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        hintText: hintText,
        labelText: labelText,
        hintStyle: GoogleFonts.outfit(
          textStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        labelStyle: GoogleFonts.outfit(
          textStyle: TextStyle(
            color: Colors.lightBlue.shade900,
            fontSize: 16,
          ),
        ),
        errorStyle: const TextStyle(
          fontSize: 14,
          color: Colors.redAccent,
        ),
      ),
      style: GoogleFonts.outfit(
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }
}
