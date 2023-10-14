part of 'locale_cubit.dart';

@immutable
class LocaleChange extends Equatable {
  final Locale locale;

  const LocaleChange({required this.locale});

  @override
  List<Object?> get props => [locale];
}
