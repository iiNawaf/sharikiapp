import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/providers/post_provider.dart';
import 'package:sharikiapp/screens/home/home.dart';
import 'package:sharikiapp/screens/login/login.dart';
import 'package:sharikiapp/screens/splash/splash.dart';
import 'package:sharikiapp/services/api_services.dart';
import 'package:sharikiapp/utilities/styles/constant_styles.dart';
import 'package:sharikiapp/widgets/loading/fetching_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                AuthProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                PostProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale("ar", "AE"),
              ],
              theme: ThemeData(
                fontFamily: 'Cairo',
                primaryColor: primaryColor,
                scaffoldBackgroundColor: bgColor,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              home: FutureBuilder<bool>(
                  future: apiServices.checkConnectivity(context),
                  builder: (context, snapshot) {
                    return snapshot.data == true
                        ? FutureBuilder(
                            future: authProvider.autoLogin(),
                            builder: (context, snapshot) {
                              return snapshot.connectionState ==
                                      ConnectionState.done
                                  ? snapshot.hasData
                                      ? HomeScreen()
                                      : LoginScreen()
                                  : SplashScreen();
                            },
                          )
                        : FetchingDataLoading();
                  }),
            ),
          );
        },
      ),
    );
  }
}
