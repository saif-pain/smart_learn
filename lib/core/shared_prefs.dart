import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_time') ?? true;
  }

  static Future<void> setFirstLaunchFalse() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_time', false);
  }
  
  // Save student ID when user logs in
  static Future<void> saveStudentId(String studentId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('student_id', studentId);
  }
  
  // Get stored student ID
  static Future<String?> getStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('student_id');
  }
  
  // Clear student ID on logout
  static Future<void> clearStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('student_id');
  }
}
