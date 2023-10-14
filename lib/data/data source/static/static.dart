import 'package:test/core/constant/app_image_asset.dart';
import 'package:test/data/model/onboarding_model.dart';
import 'package:test/generated/l10n.dart';

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      title: S.current.onboarding_title_page_one,
      body: S.current.onboarding_body_page_one,
      image: AppImageAsset.onBoardingImageOne),
  OnBoardingModel(
      title: S.current.onboarding_title_page_two,
      body: S.current.onboarding_body_page_two,
      image: AppImageAsset.onBoardingImageTwo),
  OnBoardingModel(
      title: S.current.onboarding_title_page_three,
      body: S.current.onboarding_body_page_three,
      image: AppImageAsset.onBoardingImageThree),
];
