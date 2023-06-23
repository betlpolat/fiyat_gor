import 'package:fiyat_gor/shared_pref.dart';
import 'package:fiyat_gor/state_data.dart';
import 'package:fiyat_gor/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPref sharedPref = SharedPref();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [SystemUiOverlay.top]);
  runApp(ChangeNotifierProvider<StateData>(
      create: (BuildContext context) {
        return StateData();
      },
      child:const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: Constants.appTitle,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        theme: ThemeData(
          primaryColor: Constants.mainColor,
          scaffoldBackgroundColor: Constants.whiteColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(Constants.defaultBorderRadius),
              ),
              elevation: 0,
              backgroundColor: Constants.mainColor,
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Constants.mainColor),
                borderRadius: BorderRadius.circular(50)),
            filled: true,
            fillColor: Constants.whiteColor,
            iconColor: Constants.mainColor,
            focusColor: Constants.mainColor,
            hoverColor: Constants.mainColor,
            hintStyle: const TextStyle(
              //fontSize: 16,
              color: Constants.greyColor,
            ),
            prefixIconColor: Constants.mainColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: Constants.defaultPadding,
                vertical: Constants.defaultPadding),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Constants.greyColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
