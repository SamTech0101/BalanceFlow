import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SMSStorage {
  static final SMSStorage _singleton = SMSStorage._internal();

  factory SMSStorage() {
    return _singleton;
  }

  SMSStorage._internal();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/sms_messages.txt');
  }

  Future<File> writeSMS(String message) async {
    final file = await _localFile;
    // Write the SMS to the file
    return file.writeAsString('$message\n', mode: FileMode.append);
  }

  Future<List<String>> readSMS() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      return contents.split('\n'); // Split the file content into lines
    } catch (e) {
      // If encountering an error, return an empty list
      return [];
    }
  }
}
