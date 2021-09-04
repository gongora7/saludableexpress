import 'package:flutter/material.dart';
import 'package:flutter_app1/src/blocs/categories/categories_bloc.dart';
import 'package:flutter_app1/src/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_app1/src/blocs/add_to_order/order_bloc.dart';
import 'package:flutter_app1/src/blocs/my_address/my_address_bloc.dart';
import 'package:flutter_app1/src/blocs/orders/my_orders_bloc.dart';
import 'package:flutter_app1/src/blocs/search/search_bloc.dart';
import 'package:flutter_app1/src/blocs/server_settings/server_settings_bloc.dart';
import 'package:flutter_app1/src/blocs/shipping_methods/shipping_methods_bloc.dart';
import 'package:flutter_app1/src/blocs/user/login_bloc.dart';
import 'package:flutter_app1/src/repositories/address_repo.dart';
import 'package:flutter_app1/src/repositories/categories_repo.dart';
import 'package:flutter_app1/src/repositories/checkout_repo.dart';
import 'package:flutter_app1/src/repositories/orders_repo.dart';
import 'package:flutter_app1/src/repositories/search_repo.dart';
import 'package:flutter_app1/src/repositories/settings_repo.dart';
import 'package:flutter_app1/src/repositories/shipping_methods_repo.dart';
import 'package:flutter_app1/src/repositories/user_repo.dart';
import 'package:flutter_app1/src/utils/theme_utils/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'ui/screens/splash_screen.dart';
import 'utils/locale_utils/app_localization.dart';
import 'utils/locale_utils/language_bloc.dart';
import 'utils/theme_utils/app_themes.dart';
import 'utils/theme_utils/bloc/theme_bloc.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          //BlocProvider(create: (context) => BannersBloc(RealBannersRepo())),
          BlocProvider(create: (context) => LoginBloc(RealUserRepo())),
          BlocProvider(
            create: (context) => MyAddressBloc(RealAddressRepo()),
          ),
          BlocProvider(
            create: (context) => SearchBloc(RealSearchRepo()),
          ),
          BlocProvider(
            create: (context) => MyOrdersBloc(RealOrdersRepo()),
          ),
          BlocProvider(
              create: (context) =>
                  ShippingMethodsBloc(RealShippingMethodsRepo())),
          BlocProvider(create: (context) => OrderBloc(RealCheckoutRepo())),
          BlocProvider(create: (context) => CheckoutBloc(RealCheckoutRepo())),
          BlocProvider(
              create: (context) => CategoriesBloc(RealCategoriesRepo())),
          BlocProvider(
              create: (context) => LanguageBloc()..add(LanguageLoadStarted())),
          BlocProvider(
              create: (context) => ThemeBloc(
                  ThemeState(themeData: appThemeData[AppTheme.EEVDark])))
        ],
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: _buildWithLanguage,
        ));
  }
}

Widget _buildWithLanguage(BuildContext context, LanguageState languageState) {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, themeState) => MaterialApp(
      locale: languageState.lcoale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'),
        //Locale('ar', 'AE'),
      ],
      theme: themeState.themeData,
      debugShowCheckedModeBanner: false,
      home: Container(
        child: BlocProvider(
          create: (context) => ServerSettingsBloc(RealServerSettingsRepo()),
          child: SplashScreen(),
        ),
      ),
    ),
  );
}
