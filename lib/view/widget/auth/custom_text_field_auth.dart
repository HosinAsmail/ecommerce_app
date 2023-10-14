import 'package:flutter/material.dart';

class CustomTextFieldAuth extends StatefulWidget {
  const CustomTextFieldAuth(
      {super.key,
      required this.hintText,
      required this.label,
      required this.iconData,
      required this.controller,
      required this.validator,
      required this.keyboardType,
      this.obscureText = false,
      this.onPressedIcon,
      this.textDirection,
      this.onSaved});
  final String hintText;
  final String label;
  final IconData iconData;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final void Function()? onPressedIcon;
  final bool obscureText;
  final void Function(String?)? onSaved;
  final TextDirection? textDirection;
  @override
  State<CustomTextFieldAuth> createState() => _CustomTextFieldAuthState();
}

class _CustomTextFieldAuthState extends State<CustomTextFieldAuth> {
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    obscureText = obscureText ?? widget.obscureText;
    return TextFormField(
      onSaved: widget.onSaved,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      obscureText: obscureText!,
      textDirection:widget.textDirection ,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontSize: 12),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Container(
              margin: const EdgeInsets.symmetric(horizontal: 9),
              child: Text(widget.label)),
          suffixIcon: IconButton(
              onPressed: widget.onPressedIcon == null
                  ? null
                  : () {
                      setState(() {
                        obscureText = !obscureText!;
                      });
                    },
              icon: Icon(widget.iconData)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
    );
  }
}
