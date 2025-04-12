class Student {
  final String studentId;
  final String fkCampus;
  final String campusName;
  final String studentName;
  final String batchId;
  final int batchNo;
  final int programCredit;
  final String programId;
  final String programName;
  final String progShortName;
  final String programType;
  final String deptShortName;
  final String departmentName;
  final String facultyName;
  final String facShortName;
  final String semesterId;
  final String semesterName;
  final String shift;

  Student({
    required this.studentId,
    required this.fkCampus,
    required this.campusName,
    required this.studentName,
    required this.batchId,
    required this.batchNo,
    required this.programCredit,
    required this.programId,
    required this.programName,
    required this.progShortName,
    required this.programType,
    required this.deptShortName,
    required this.departmentName,
    required this.facultyName,
    required this.facShortName,
    required this.semesterId,
    required this.semesterName,
    required this.shift,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['studentId'] ?? '',
      fkCampus: json['fkCampus'] ?? '',
      campusName: json['campusName'] ?? '',
      studentName: json['studentName'] ?? '',
      batchId: json['batchId'] ?? '',
      batchNo: json['batchNo'] ?? 0,
      programCredit: json['programCredit'] ?? 0,
      programId: json['programId'] ?? '',
      programName: json['programName'] ?? '',
      progShortName: json['progShortName'] ?? '',
      programType: json['programType'] ?? '',
      deptShortName: json['deptShortName'] ?? '',
      departmentName: json['departmentName'] ?? '',
      facultyName: json['facultyName'] ?? '',
      facShortName: json['facShortName'] ?? '',
      semesterId: json['semesterId'] ?? '',
      semesterName: json['semesterName'] ?? '',
      shift: json['shift'] ?? '',
    );
  }
}