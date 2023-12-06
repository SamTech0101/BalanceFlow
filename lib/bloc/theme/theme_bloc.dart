import 'package:BalanceFlow/utils/theme_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent,ThemeState>{
  ThemeBloc():super(ThemeState(themeData: lightTheme)){
    on<ToggleTheme>((event, emit) {
      emit(state.themeData == lightTheme?
      ThemeState(themeData: darkTheme) : ThemeState(themeData: lightTheme)
      );

    });
  }
  
}