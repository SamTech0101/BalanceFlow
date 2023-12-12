import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String errorMessage) {
  final snackBar = SnackBar(
    content: Text(errorMessage,style: const TextStyle(color: Colors.white),),
    backgroundColor: Colors.red.shade400, // Red color for error messages
    behavior: SnackBarBehavior.floating, // Optional: changes how the snack bar behaves
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar() // Hide any existing snack bars
    ..showSnackBar(snackBar); // Show the new snack bar
}