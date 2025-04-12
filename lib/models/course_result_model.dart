class CourseResult {
  final String courseId;
  final String customCourseId;
  final String courseTitle;
  final double totalCredit;
  final double pointEquivalent;
  final String gradeLetter;
  final String? blocked;
  final String? blockCause;
  final String? tevalSubmitted;
  final String? teval;

  CourseResult({
    required this.courseId,
    required this.customCourseId,
    required this.courseTitle,
    required this.totalCredit,
    required this.pointEquivalent,
    required this.gradeLetter,
    this.blocked,
    this.blockCause,
    this.tevalSubmitted,
    this.teval,
  });

  factory CourseResult.fromJson(Map<String, dynamic> json) {
    return CourseResult(
      courseId: json['courseId'] ?? '',
      customCourseId: json['customCourseId'] ?? '',
      courseTitle: json['courseTitle'] ?? '',
      totalCredit: json['totalCredit'] is int 
          ? (json['totalCredit'] as int).toDouble() 
          : json['totalCredit']?.toDouble() ?? 0.0,
      pointEquivalent: json['pointEquivalent'] is int 
          ? (json['pointEquivalent'] as int).toDouble() 
          : json['pointEquivalent']?.toDouble() ?? 0.0,
      gradeLetter: json['gradeLetter'] ?? '',
      blocked: json['blocked'],
      blockCause: json['blockCause'],
      tevalSubmitted: json['tevalSubmitted'],
      teval: json['teval'],
    );
  }
}