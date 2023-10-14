import 'package:test/core/constant/app_theme.dart';
import 'package:test/core/services/init%20services/init_services.dart';
import 'package:test/cubits/address%20cubit/address_cubit.dart';
import 'package:test/cubits/cart%20cubit/cart_cubit.dart';
import 'package:test/cubits/favorite%20cubit/favorite_cubit.dart';
import 'package:test/cubits/notification%20cubit/notification_cubit.dart';
import 'package:test/cubits/order%20cubit/order_cubit.dart';
import 'package:test/cubits/product%20cubit/product_cubit.dart';
import 'package:test/cubits/search%20cubit/search_cubit.dart';
import 'package:test/debug/app_bloc_observer.dart';
import 'package:test/routs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'cubits/auth cubit/auth_cubit.dart';
import 'cubits/home cubit/home_cubit.dart';
import 'cubits/locale cubit/locale_cubit.dart';
import 'generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await InitServices().init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => AuthCubit()),
    BlocProvider(create: (context) => SearchCubit()),
    BlocProvider(create: (context) => LocaleCubit()),
    BlocProvider(create: (context) => ProductCubit()),
    BlocProvider(create: (context) => FavoriteCubit()),
    BlocProvider(create: (context) => CartCubit()),
    BlocProvider(create: (context) => OrderCubit()),
    BlocProvider(create: (context) => AddressCubit()),
    BlocProvider(create: (context) => NotificationCubit()),

    BlocProvider(
      create: (context) => HomeCubit()..getData(),
    )
  ], child: const EcommerceApp()));
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleChange>(
      // buildWhen:(pre,current){
      //   if(current.locale.languageCode =='ar' ){
      //     return true;
      //   }else{
      //     return false;
      //   }
      // },
      builder: (context, state) {
        print(state.locale.languageCode);
        return GetMaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: arabicTheme,
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar'),
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (deviceLocale != null &&
                  deviceLocale.languageCode == locale.languageCode) {
                return deviceLocale;
              }
            }

            return supportedLocales.first;
          },
          getPages: routes,
        );
      },
    );
  }
}
