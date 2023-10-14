import 'package:test/core/extension/number_extensions.dart';
import 'package:test/data/model/ad_model.dart';
import 'package:test/view/widget/home/side_circle.dart';
import 'package:test/view/widget/home/surprise_body_box.dart';
import 'package:flutter/material.dart';

class SurpriseBox extends StatelessWidget {
  const SurpriseBox({super.key, required this.adModel});
  final AdModel adModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Stack(children: [
        SurpriseBodyBox(
          adModel: adModel,
        ),
        SideCircle(
          color: adModel.adsColorCircle!.toInt(),
        )
      ]),
    );
  }
}
