import 'package:flutter/material.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';

import '../themes/colors.dart';

InputDecoration textFieldDecoration(String hintText, [String? labelText]) {
  return InputDecoration(
    label: labelText != null ? Text(labelText, style: AppTextStyles.titleTextStyle,) : null,
    hintText: hintText,
    hintStyle: const TextStyle(
      fontSize: 14, 
      fontWeight: FontWeight.normal,
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.grey3), 
        borderRadius: BorderRadius.all(Radius.circular(4))
    ),
    constraints: const BoxConstraints(
      maxHeight: 50,
      maxWidth: 500
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.grey3, 
        width: 2
      )
    )
  );
}