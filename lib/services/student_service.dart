import 'package:smart_learn/core/shared_prefs.dart';
import 'package:smart_learn/models/student_model.dart';
import 'package:smart_learn/services/result_service.dart';

class StudentService {
  // Singleton pattern for StudentService
  static final StudentService _instance = StudentService._internal();
  factory StudentService() => _instance;
  StudentService._internal();

  // Cache the student information
  Student? _currentStudent;
  final ResultService _resultService = ResultService();

  // Get the current student information
  Future<Student?> getCurrentStudent() async {
    // Return cached student if available
    if (_currentStudent != null) {
      return _currentStudent;
    }

    // Get stored student ID
    final studentId = await SharedPrefs.getStudentId();
    if (studentId == null || studentId.isEmpty) {
      return null;
    }

    try {
      // Fetch student information
      _currentStudent = await _resultService.fetchStudentInfo(studentId);
      return _currentStudent;
    } catch (e) {
      print('Error fetching student info: $e');
      return null;
    }
  }

  // Clear cached student on logout
  void clearCurrentStudent() {
    _currentStudent = null;
  }

  // Get student name or default value
  Future<String> getStudentName({String defaultName = 'Student'}) async {
    final student = await getCurrentStudent();
    return student?.studentName ?? defaultName;
  }

  // Get student email (generated from student ID for DIU)
  Future<String> getStudentEmail({String defaultEmail = 'student@diu.edu.bd'}) async {
    final student = await getCurrentStudent();
    if (student == null) return defaultEmail;
    
    // Generate email from student ID (this is a common format for DIU)
    // You might need to adjust this pattern based on your university's email format
    String studentId = student.studentId.replaceAll('-', '').toLowerCase();
    return '$studentId@diu.edu.bd';
  }

  // Get student department
  Future<String> getStudentDepartment({String defaultDept = 'Department'}) async {
    final student = await getCurrentStudent();
    return student?.departmentName ?? defaultDept;
  }

  // Get student ID
  Future<String> getStudentId({String defaultId = ''}) async {
    final student = await getCurrentStudent();
    return student?.studentId ?? defaultId;
  }
}