import 'package:flutter/material.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';

import '../themes/colors.dart';


class CustomButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final String? header;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final double? margin;
  final MainAxisAlignment? mainAxisAlignment;

  // Конструктор для кнопки с иконкой и текстом
  const CustomButton.icon({
    super.key,
    required this.text,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.width, 
    this.height, 
    this.margin, this.mainAxisAlignment,
  })  : header = null;

  // Конструктор для кнопки с иконкой, заголовком и текстом
  const CustomButton.header({
    super.key,
    required this.header,
    required this.text,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.width, 
    this.height, 
    this.margin, this.mainAxisAlignment,
  });

  // Конструктор для обычной кнопки с текстом
  const CustomButton.normal({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.width, this.height, 
    this.margin, this.mainAxisAlignment
  })  : icon = null,
        header = null;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 0, 
        vertical: widget.margin ?? 0
      ),
      child: ElevatedButton(
        style: _style(
          widget.backgroundColor ?? AppColors.orange,
          widget.width ?? double.infinity,
          widget.height ?? double.minPositive + (widget.header != null ? 15 : 0),
          
        ),
        onPressed: widget.onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
          children: _buildChildren(),
        ),
      ),
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> children = [];

    if (widget.icon != null) {
      children.add(
        Icon(
          widget.icon,
          size: 24,
          color: const Color(0xFF171A1F),
        ),
      );
      children.add(const SizedBox(width: 10));
    }

    if (widget.header != null) {
      children.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.header!,
              style: const TextStyle(
                color: Color(0xFF171A1F),
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: (widget.width! - 100),
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Color(0xFF9095A1),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      children.add(
        Text(widget.text, style: AppTextStyles.titleTextStyle.copyWith(fontWeight: FontWeight.w500),),
      );
    }

    return children;
  }
}


ButtonStyle _style(Color backgroundColor, double width, double height) {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(backgroundColor),
    foregroundColor: WidgetStateProperty.all<Color>(const Color.fromRGBO(23, 26, 31, 1)),
    padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
    ),
    minimumSize: WidgetStateProperty.all<Size>(
      const Size(0, 40), // Значение минимальной ширины изменено на 0
    ),
    maximumSize: WidgetStateProperty.all<Size>(
      const Size(double.infinity, double.infinity)
    ),
    fixedSize: WidgetStateProperty.all<Size>(
      Size(width, height), 
    ),
  );
}
