import 'package:bloc/bloc.dart';
import 'package:test/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleChange> {
  LocaleCubit() : super(const LocaleChange(locale: Locale('ar')));

  Future<void> changeLocale(String languageCode) async {
    // S.load(Locale(languageCode));
    emit(LocaleChange(locale: Locale(languageCode)));
  }
}
