import 'package:smart_learn/models/course_result_model.dart';

class SemesterResult {
  final String semesterId;
  final String semesterName;
  final int? semesterYear;
  final String studentId;
  final double? cgpa;
  final List<CourseResult> courses;

  SemesterResult({
    required this.semesterId,
    required this.semesterName,
    this.semesterYear,
    required this.studentId,
    this.cgpa,
    required this.courses,
  });

  factory SemesterResult.fromApiResponse(List<dynamic> response) {
    if (response.isEmpty) {
      return SemesterResult(
        semesterId: '',
        semesterName: '',
        semesterYear: null,
        studentId: '',
        cgpa: 0.0,
        courses: [],
      );
    }
    
    // Extract common semester data from the first item
    final firstItem = response.first;
    final semesterId = firstItem['semesterId'] ?? '';
    final semesterName = firstItem['semesterName'] ?? '';
    final semesterYear = firstItem['semesterYear'];
    final studentId = firstItem['studentId'] ?? '';
    
    // Use the CGPA from the first item (should be same for all items in the semester)
    final cgpa = firstItem['cgpa'] is int 
        ? (firstItem['cgpa'] as int).toDouble() 
        : firstItem['cgpa']?.toDouble() ?? 0.0;
    
    // Convert all results to CourseResult objects
    final courses = response.map((item) => CourseResult.fromJson(item)).toList();
    
    return SemesterResult(
      semesterId: semesterId,
      semesterName: semesterName,
      semesterYear: semesterYear,
      studentId: studentId,
      cgpa: cgpa,
      courses: courses,
    );
  }

  // Calculate semester GPA
  double calculateGPA() {
    if (courses.isEmpty) return 0.0;
    
    double totalCredits = 0;
    double totalPoints = 0;

    for (var course in courses) {
      totalCredits += course.totalCredit;
      totalPoints += course.totalCredit * course.pointEquivalent;
    }

    return totalPoints / totalCredits;
  }

  // Calculate total credits for the semester
  double calculateTotalCredits() {
    return courses.fold(0.0, (sum, course) => sum + course.totalCredit);
  }
  
  // Format semester name with year
  String getFormattedSemesterName() {
    return semesterYear != null ? '$semesterName $semesterYear' : semesterName;
  }
}