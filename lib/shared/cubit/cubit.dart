import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwes_ap/shared/cubit/states.dart';
import 'package:nwes_ap/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  void changeAppMode({
    bool? isDarkfromShared
  })
  {
    if (isDarkfromShared != null)   //when we call changeAppMode() from the main
    {
      isDark = isDarkfromShared;
      emit(AppChangeModeState());
    } else    //when we call changeAppMode() from the button
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}