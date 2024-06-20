import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final IconData? suffixIcon;
  final String hint;
  final bool isObscure;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.isObscure,
    this.suffixIcon,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscure;

  @override
  void initState() {
    setState(() {
      _isObscure = widget.isObscure;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      validator: widget.validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF4F4F9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: Icon(
                  _isObscure ? FeatherIcons.eye : FeatherIcons.eyeOff,
                ),
              )
            : null,
        hintText: widget.hint,
      ),
    );
  }
}
