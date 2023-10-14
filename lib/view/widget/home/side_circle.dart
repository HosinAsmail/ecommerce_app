import 'package:flutter/material.dart';
import 'package:test/core/services/storage%20services/store_language_service.dart';

class SideCircle extends StatelessWidget {
  const SideCircle({
    super.key, required this.color,
  });
 final int color;
  @override
  Widget build(BuildContext context) {
    bool isArabic = StoreLanguageService().getLocale() == const Locale('ar');
    isArabic = true;
    return Positioned(
      top: -20,
      right: isArabic ? null : -20,
      left: isArabic ? -20 : null,
      child: Container(
        height: 160,
        width: 160,
        decoration: BoxDecoration(
            color:  Color(color),
            borderRadius: BorderRadius.circular(160)),
      ),
    );
  }
}
