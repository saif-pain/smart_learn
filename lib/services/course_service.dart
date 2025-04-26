import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseService {
  // Key for storing enrolled courses in SharedPreferences
  static const String _enrolledCoursesKey = 'enrolled_courses';
  
  // Get the current user ID or use a default anonymous ID
  String get _userId {
    return FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';
  }
  
  // Get the user-specific key for storing enrolled courses
  String get _userEnrolledCoursesKey => '${_enrolledCoursesKey}_${_userId}';

  // Get list of enrolled course IDs
  Future<List<String>> getEnrolledCourses() async {
    final prefs = await SharedPreferences.getInstance();
    final courses = prefs.getStringList(_userEnrolledCoursesKey) ?? [];
    return courses;
  }

  // Check if a course is enrolled
  Future<bool> isEnrolled(String courseId) async {
    final enrolledCourses = await getEnrolledCourses();
    return enrolledCourses.contains(courseId);
  }

  // Enroll in a course
  Future<bool> enrollCourse(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final enrolledCourses = await getEnrolledCourses();
    
    if (!enrolledCourses.contains(courseId)) {
      enrolledCourses.add(courseId);
      return await prefs.setStringList(_userEnrolledCoursesKey, enrolledCourses);
    }
    
    return true; // Already enrolled
  }

  // Unenroll from a course
  Future<bool> unenrollCourse(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final enrolledCourses = await getEnrolledCourses();
    
    if (enrolledCourses.contains(courseId)) {
      enrolledCourses.remove(courseId);
      return await prefs.setStringList(_userEnrolledCoursesKey, enrolledCourses);
    }
    
    return true; // Wasn't enrolled anyway
  }
}