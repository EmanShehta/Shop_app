import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_app_layout.dart';
import 'package:shop_app/on_boarding/on_boarding.dart';
import 'package:shop_app/shared/Constants.dart';
import 'Screens/login/login.dart';
import 'Styles/themes.dart';
import 'layout/Cubit/cubit.dart';
import 'layout/Cubit/observer.dart';
import 'network/local/cachehelper.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CahceHelper.init();
   bool ?onBoardingFinish = CahceHelper.getData(Key: 'onBorading');
  print(onBoardingFinish);
   token = CahceHelper.getData(Key: 'token');
  Bloc.observer = MyBlocObserver();
 await DioHelper.init();
   Widget start;
  if (onBoardingFinish != null) {
    if (token != null)
      start = shop_layout();
    else
      start = Shoplogin_screen();
  } else
    start = onBoarding_screen();
  runApp(MyApp(start));
}
class MyApp extends StatelessWidget {
  final Widget? startWidget;
  MyApp(this.startWidget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => Shopcubit()..getHomeData()..getCategories()..getFavorite()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'flutter',
        theme: lighttheme,
        darkTheme: darktheme,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}
