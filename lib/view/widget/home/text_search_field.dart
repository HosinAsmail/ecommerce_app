import 'package:flutter/material.dart';

class TextSearchField extends StatelessWidget {
  const TextSearchField({
    super.key,
    required this.text,
    this.onFieldSubmitted,
    this.onChanged,
    required this.onPressed,
  });
  final String text;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: onPressed,
          ),
          hintText: text,
          hintStyle: const TextStyle(fontSize: 18),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[200]),
    );
  }
}
