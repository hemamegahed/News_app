import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nwes_ap/layout/cubit/cubit.dart';
import 'package:nwes_ap/layout/news_layout.dart';
import 'package:nwes_ap/shared/bloc_observer.dart';
import 'package:nwes_ap/shared/cubit/cubit.dart';
import 'package:nwes_ap/shared/cubit/states.dart';
import 'package:nwes_ap/shared/network/local/cache_helper.dart';
import 'package:nwes_ap/shared/network/remote/dio_helper.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized(); // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن

  Bloc.observer = MyBlocObserver();

  DioHelper.init();

  //lAn ba await ala CacheHelper.init() lazem el main ybka async we lAn el main bka async lazwm adef el method...> WidgetsFlutterBinding.ensureInitialized()
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {

  bool? isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()..getBusiness()..getSports()..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()..changeAppMode(isDarkfromShared: isDark),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleSpacing: 20.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backwardsCompatibility: false,               //false alashan aref aAdel fe el status bar
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
              primarySwatch: Colors.deepOrange,            //haylwn el CircularProgressIndicator
              scaffoldBackgroundColor: Colors.white,
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
 //              floatingActionButtonTheme: FloatingActionButtonThemeData(
//                backgroundColor: Colors.deepOrange,),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
              ),
            ),

            darkTheme: ThemeData(
              appBarTheme: AppBarTheme(
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                titleSpacing: 20.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                backwardsCompatibility: false,           //false alashan aref aAdel fe el status bar
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
               primarySwatch: Colors.deepOrange,
               scaffoldBackgroundColor: HexColor('333739'),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
//              floatingActionButtonTheme: FloatingActionButtonThemeData(
//                backgroundColor: Colors.deepOrang),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: HexColor('333739'),
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
              ),
            ),

            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,

            debugShowCheckedModeBanner: false,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}