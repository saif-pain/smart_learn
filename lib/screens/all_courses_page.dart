import 'package:flutter/material.dart';
import 'package:smart_learn/core/app_colors.dart';
import 'package:smart_learn/models/course.dart';
import 'package:smart_learn/services/course_service.dart';

class AllCoursesPage extends StatefulWidget {
  const AllCoursesPage({Key? key}) : super(key: key);

  @override
  State<AllCoursesPage> createState() => _AllCoursesPageState();
}

class _AllCoursesPageState extends State<AllCoursesPage> {
  final CourseService _courseService = CourseService();
  bool _isLoading = true;
  List<Course> _allCourses = [];

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    // List of all courses
    final courseData = [
      {
        'id': 'compiler_design',
        'title': 'Compiler Design',
        'image': 'assets/images/compiler.png',
        'progress': 0.5,
        'description': 'Learn the fundamentals of compiler design and implementation.',
      },
      {
        'id': 'mobile_app_design',
        'title': 'Mobile App Design',
        'image': 'assets/images/MAD.png',
        'progress': 0.7,
        'description': 'Learn to design beautiful mobile applications with Flutter.',
      },
      {
        'id': 'mobile_app_design_lab',
        'title': 'Mobile App Design Lab',
        'image': 'assets/images/mad_lab.png',
        'progress': 0.7,
        'description': 'Practical lab sessions for mobile app development.',
      },
      {
        'id': 'artificial_intelligence',
        'title': 'Artificial Intelligence',
        'image': 'assets/images/opp.png',
        'progress': 0.8,
        'description': 'Introduction to AI concepts and applications.',
      },
      {
        'id': 'computer_architecture',
        'title': 'Computer Architecture & Organization',
        'image': 'assets/images/cao.png',
        'progress': 0.9,
        'description': 'Learn about the structure and function of computer systems.',
      },
      {
        'id': 'basic_physics',
        'title': 'Basic Physics',
        'image': 'assets/images/phy.png',
        'progress': 0.5,
        'description': 'Fundamental physics concepts for computer science students.',
      },
      {
        'id': 'biology_chemistry_computation',
        'title': 'Introduction to Biology and Chemistry for Computation',
        'image': 'assets/images/bio_com.png',
        'progress': 0.6,
        'description': 'Learn how biological and chemical principles apply to computation.',
      },
      {
        'id': 'physics_lab',
        'title': 'Basic Physics Lab',
        'image': 'assets/images/phy_lab.png',
        'progress': 0.3,
        'description': 'Practical experiments in basic physics.',
      },
      {
        'id': 'computer_fundamentals',
        'title': 'Computer Fundamentals',
        'image': 'assets/images/com_f.png',
        'progress': 0.7,
        'description': 'Introduction to the fundamental concepts of computing.',
      },
      {
        'id': 'functional_english',
        'title': 'Basic Functional English and English Spoken',
        'image': 'assets/images/basic_eng.png',
        'progress': 0.5,
        'description': 'Improve your English communication skills.',
      },
      {
        'id': 'basic_mathematics',
        'title': 'Basic Mathematics',
        'image': 'assets/images/mat.png',
        'progress': 0.4,
        'description': 'Core mathematical concepts for computer science.',
      },
      {
        'id': 'mathematics_2',
        'title': 'Mathematics-II',
        'image': 'assets/images/mat2.png',
        'progress': 0.8,
        'description': 'Advanced mathematical concepts for computer science.',
      },
      {
        'id': 'writing_comprehension',
        'title': 'Writing and Comprehension',
        'image': 'assets/images/wr.png',
        'progress': 0.9,
        'description': 'Develop your writing and reading comprehension skills.',
      },
    ];

    // Convert to Course objects
    List<Course> courses = [];
    
    for (final course in courseData) {
      final isEnrolled = await _courseService.isEnrolled(course['id'] as String);
      courses.add(
        Course(
          id: course['id'] as String,
          title: course['title'] as String,
          image: course['image'] as String,
          progress: course['progress'] as double,
          description: course['description'] as String,
          isEnrolled: isEnrolled,
        ),
      );
    }

    if (mounted) {
      setState(() {
        _allCourses = courses;
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleEnrollment(Course course) async {
    setState(() {
      _isLoading = true;
    });

    if (course.isEnrolled) {
      await _courseService.unenrollCourse(course.id);
    } else {
      await _courseService.enrollCourse(course.id);
    }

    await _loadCourses(); // Refresh courses
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Courses'),
        backgroundColor: AppColors.primary,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _allCourses.length,
              itemBuilder: (context, index) {
                final course = _allCourses[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Course Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            course.image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Course Title and Progress
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Progress Bar (Show only if enrolled)
                              if (course.isEnrolled) ...[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    value: course.progress,
                                    backgroundColor: Colors.grey[200],
                                    color: AppColors.primary,
                                    minHeight: 6,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${(course.progress * 100).toInt()}% Done',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 8),
                              // Enrollment Button
                              ElevatedButton(
                                onPressed: () => _toggleEnrollment(course),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: course.isEnrolled
                                      ? Colors.red[400]
                                      : AppColors.primary,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(120, 36),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  course.isEnrolled ? 'Unenroll' : 'Enroll',
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Arrow Icon for details
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          color: Colors.grey,
                          onPressed: () {
                            // Navigate to course details
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
