import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwes_ap/layout/cubit/states.dart';
import 'package:nwes_ap/modules/business/business_screen.dart';
import 'package:nwes_ap/modules/science/science_screen.dart';
import 'package:nwes_ap/modules/sports/sports_screen.dart';
import 'package:nwes_ap/shared/network/remote/dio_helper.dart';



class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    emit(NewsBottomNavState());
  }


  List<dynamic> business = [];

  void getBusiness()
  {
//    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
            'country':'eg',
            'category':'business',
            'apiKey':'48a75c8eaa9240338951f064291813df',
             },
    ).then((value)
    {
      business = value.data['articles'];

      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }


  List<dynamic> sports = [];

  void getSports()
  {
//    emit(NewsGetSportsLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'sports',
        'apiKey':'48a75c8eaa9240338951f064291813df',
      },
    ).then((value)
    {
      sports = value.data['articles'];

      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }


  List<dynamic> science = [];

  void getScience()
  {
//    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'science',
        'apiKey':'48a75c8eaa9240338951f064291813df',
      },
    ).then((value)
    {
      science = value.data['articles'];

      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });

  }



  List<dynamic> search = [];

  void getSearch(String value)
  {
//    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'48a75c8eaa9240338951f064291813df',
      },
    ).then((value)
    {
      search = value.data['articles'];

      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}