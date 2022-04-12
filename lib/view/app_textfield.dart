import 'package:flutter/material.dart';
import 'package:login_flutter_app/constant/app_colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    required this.label,
    required this.validator,
    required this.controller,
    this.maxLines = 1,
    this.isPassWordField = false,
    this.enabled = true,
  }) : super(key: key);

  final String label;
  final FormFieldValidator validator;
  final TextEditingController controller;
  final bool isPassWordField, enabled;
  final int maxLines;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _passwordVisible = widget.isPassWordField;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.maxLines == 1 ? 50 : widget.maxLines * 30,
      // padding: EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 1.7, left: 5, right: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        // borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        style: const TextStyle(
          color: AppColors.textFormFieldTextColor,
        ),
        enabled: widget.enabled,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: _passwordVisible,
        maxLines: widget.maxLines,
        cursorColor: AppColors.textFormFieldTextColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10),
          border: InputBorder.none,
          hintText: widget.label,
          hintStyle: const TextStyle(
            color: AppColors.textFormFieldTextColor,
            fontSize: 14,
          ),
          suffixIcon: widget.isPassWordField
              ? IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
