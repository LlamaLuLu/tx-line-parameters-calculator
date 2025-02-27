import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserInputs {
  static final UserInputs _instance = UserInputs._internal();
  factory UserInputs() => _instance;
  UserInputs._internal();

  // Get file path for storing data
  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/user_inputs.json';
  }

  // Save a new calculation to history
  Future<void> saveInput(Map<String, dynamic> inputData) async {
    final file = File(await _getFilePath());
    List<Map<String, dynamic>> history = await loadInputs(); // Load past data
    history.insert(0, inputData); // Insert new record at the top
    await file.writeAsString(jsonEncode(history)); // Save back to file
  }

  // Load all previous calculations
  Future<List<Map<String, dynamic>>> loadInputs() async {
    try {
      final file = File(await _getFilePath());
      if (!await file.exists()) return [];
      final content = await file.readAsString();
      return List<Map<String, dynamic>>.from(jsonDecode(content));
    } catch (e) {
      return [];
    }
  }
}
