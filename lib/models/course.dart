class Course {
  final String id;
  final String title;
  final String image;
  final double progress;
  final String description;
  final String instructor;
  bool isEnrolled;

  Course({
    required this.id,
    required this.title,
    required this.image,
    this.progress = 0.0,
    this.description = '',
    this.instructor = 'DIU Faculty',
    this.isEnrolled = false,
  });

  Course copyWith({
    String? id,
    String? title,
    String? image,
    double? progress,
    String? description,
    String? instructor,
    bool? isEnrolled,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      progress: progress ?? this.progress,
      description: description ?? this.description,
      instructor: instructor ?? this.instructor,
      isEnrolled: isEnrolled ?? this.isEnrolled,
    );
  }
}