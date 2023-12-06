import 'package:BalanceFlow/utils/constants.dart';
import 'package:BalanceFlow/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent,ThemeState>{
  ThemeBloc():super(ThemeState(themeData: _loadInitialTheme())){
    on<InitializeTheme>((event, emit) {

      final isDarkTheme = state.themeData == darkTheme;
      _saveThemeState(!isDarkTheme);
      emit(isDarkTheme ? ThemeState(themeData: lightTheme) :
      ThemeState(themeData: darkTheme));
    });
  }
  static ThemeData _loadInitialTheme() {
    final box = Hive.box(hiveThemeKey);
    final isDarkTheme = box.get(hiveThemeStateKey, defaultValue: false) as bool;
    return isDarkTheme ? darkTheme : lightTheme;
  }
  void _saveThemeState(bool isDarkTheme)async{
    final themeBox = Hive.box(hiveThemeKey);
    await themeBox.put(hiveThemeStateKey, isDarkTheme);
  }

}
