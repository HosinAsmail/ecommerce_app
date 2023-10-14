import 'package:test/core/constant/routes.dart';
import 'package:test/core/services/storage%20services/store_step_service.dart';
import 'package:test/data/data%20source/static/static.dart';
import 'package:test/data/model/onboarding_model.dart';
import 'package:test/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: IntroductionScreen(
          skip: Text(S.of(context).onboarding_skip),
          showSkipButton: true,
          next: Text(S.of(context).onboarding_next),
          done: Text(S.of(context).onboarding_done),
          onDone: () {
            Get.offAllNamed(AppRoute.loginScreen);
            StoreStepService().setStep("1");
          },
          dotsDecorator: DotsDecorator(
            activeSize: const Size(22, 10),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          pages: [
            ...List.generate(onBoardingList.length, (index) {
              OnBoardingModel onBoardingModel = onBoardingList[index];
              return PageViewModel(
                title: onBoardingModel.title,
                body: onBoardingModel.body,
                image: Image.asset(
                  onBoardingModel.image!,
                  width: 250,
                  height: 300,
                  fit: BoxFit.fill,
                ),
              );
            })
          ],
        )));
  }
}
