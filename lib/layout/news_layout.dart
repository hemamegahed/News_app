import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwes_ap/layout/cubit/cubit.dart';
import 'package:nwes_ap/layout/cubit/states.dart';
import 'package:nwes_ap/modules/search/search_screen.dart';
import 'package:nwes_ap/shared/components/components.dart';
import 'package:nwes_ap/shared/cubit/cubit.dart';



class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(   //nAlna el BlocProvider ly el main alshan araf amel BlocConsumer fe el screen btAA el search ely btzhr lma ados ala el el search icon
      listener: (context, state) {},
      builder: (context, state)
      {

        var cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                icon: Icon(Icons.search,),
                onPressed: ()
                {
                  navigateTo(context, SearchScreen());
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.brightness_4_outlined,
                ),
                onPressed: ()
                {
                  AppCubit.get(context).changeAppMode();
                },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items:  [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.business,
                ),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.sports,
                ),
                label: 'Sports',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.science,
                ),
                label: 'Science',
              ),
            ],
          ),
        );
      },
    );
  }
}