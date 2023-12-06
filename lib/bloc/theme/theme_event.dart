import 'package:flutter/material.dart';

abstract class ThemeEvent{}
class InitializeTheme extends ThemeEvent {
final ThemeData initialTheme;
InitializeTheme(this.initialTheme);
}