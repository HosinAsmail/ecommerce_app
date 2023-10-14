import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/extension/number_extensions.dart';
import 'package:test/core/functions/translate_from_database.dart';
import 'package:test/data/model/ad_model.dart';

class SurpriseBodyBox extends StatelessWidget {
  const SurpriseBodyBox({
    super.key,
    required this.adModel,
  });
  final AdModel adModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 150,
      width: Get.width - 40,
      decoration: BoxDecoration(
          color: Color(adModel.adsColor!.toInt()),
          borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        title: Text(
            translateFromDatabase(adModel.adsTitleAr!, adModel.adsTitle!),
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        subtitle: Text(
            translateFromDatabase(adModel.adsBodyAr!, adModel.adsBody!),
            style: const TextStyle(color: Colors.white, fontSize: 30)),
      ),
    );
  }
}
