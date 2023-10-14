import 'package:test/core/constant/app_image_asset.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImageAsset.logo,
      height: 170,
    );
  }
}
