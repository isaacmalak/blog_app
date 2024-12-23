import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    this.onChanged,
    this.isPassword,
    this.maxLines = 1,
    this.minLines = 1,
    this.title,
    this.isInputEmpty = false,
    required this.validator,
    required this.hintText,
    required this.controller,
  });
  final String hintText;
  final bool? isPassword;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final int? maxLines;
  final int? minLines;
  final String? title;
  final bool? isInputEmpty;
  final String ?Function(String?)? validator;
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        const SizedBox(height: 6),
        TextFormField(
            keyboardType: TextInputType.multiline,
            controller: controller,
            obscureText: isPassword ?? false,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: hintText,
            ),
            maxLines: null,
            minLines: minLines,
            validator: validator,),
      ],
    );
  }
}
