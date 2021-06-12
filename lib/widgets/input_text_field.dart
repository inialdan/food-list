import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String label;
  final Function(String) onchange;
  final bool obsecureText;

  InputTextField({
    required this.label,
    required this.onchange,
    this.obsecureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onchange,
      obscureText: obsecureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
