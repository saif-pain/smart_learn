import 'package:flutter/material.dart';
import 'package:smart_learn/core/app_colors.dart';
import 'package:smart_learn/models/course.dart';
import 'package:smart_learn/screens/all_courses_page.dart';
import 'package:smart_learn/services/course_service.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({Key? key}) : super(key: key);

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  final CourseService _courseService = CourseService();
  bool _isLoading = true;
  List<Course> _myCourses = [];

  @override
  void initState() {
    super.initState();
    _loadEnrolledCourses();
  }

  Future<void> _loadEnrolledCourses() async {
    setState(() {
      _isLoading = true;
    });

    // Get enrolled course IDs
    final enrolledCourseIds = await _courseService.getEnrolledCourses();
    
    // If no enrolled courses, don't bother loading the course data
    if (enrolledCourseIds.isEmpty) {
      setState(() {
        _myCourses = [];
        _isLoading = false;
      });
      return;
    }

    // All available courses data (normally you'd fetch this from an API)
    final allCoursesData = [
      {
        'id': 'compiler_design',
        'title': 'Compiler Design',
        'image': 'assets/images/compiler.png', 
        'progress': 0.5,
      },
      {
        'id': 'mobile_app_design',
        'title': 'Mobile App Design',
        'image': 'assets/images/MAD.png', 
        'progress': 0.7,
      },
      {
        'id': 'mobile_app_design_lab',
        'title': 'Mobile App Design Lab',
        'image': 'assets/images/mad_lab.png', 
        'progress': 0.7,
      },
      {
        'id': 'artificial_intelligence',
        'title': 'Artificial Intelligence',
        'image': 'assets/images/opp.png',
        'progress': 0.8,
      },
      {
        'id': 'computer_architecture',
        'title': 'Computer Architecture & Organization',
        'image': 'assets/images/cao.png',
        'progress': 0.9,
      },
      {
        'id': 'artificial_intelligence_lab',
        'title': 'Artificial Intelligence Lab',
        'image': 'assets/images/ai_lab.png',
        'progress': 0.9,
      },
      {
        'id': 'compiler_design_lab',
        'title': 'Compiler Design Lab',
        'image': 'assets/images/cd_lab.png',
        'progress': 0.9,
      },
      {
        'id': 'basic_physics',
        'title': 'Basic Physics',
        'image': 'assets/images/phy.png',
        'progress': 0.5,
      },
      {
        'id': 'biology_chemistry_computation',
        'title': 'Introduction to Biology and Chemistry for Computation',
        'image': 'assets/images/bio_com.png',
        'progress': 0.6,
      },
      {
        'id': 'physics_lab',
        'title': 'Basic Physics Lab',
        'image': 'assets/images/phy_lab.png',
        'progress': 0.3,
      },
      {
        'id': 'computer_fundamentals',
        'title': 'Computer Fundamentals',
        'image': 'assets/images/com_f.png',
        'progress': 0.7,
      },
      {
        'id': 'functional_english',
        'title': 'Basic Functional English and English Spoken',
        'image': 'assets/images/basic_eng.png',
        'progress': 0.5,
      },
      {
        'id': 'basic_mathematics',
        'title': 'Basic Mathematics',
        'image': 'assets/images/mat.png',
        'progress': 0.4,
      },
      {
        'id': 'mathematics_2',
        'title': 'Mathematics-II',
        'image': 'assets/images/mat2.png',
        'progress': 0.8,
      },
      {
        'id': 'writing_comprehension',
        'title': 'Writing and Comprehension',
        'image': 'assets/images/wr.png',
        'progress': 0.9,
      },
    ];

    // Filter for only enrolled courses
    final enrolledCourses = allCoursesData
        .where((courseData) => enrolledCourseIds.contains(courseData['id']))
        .map((courseData) => Course(
              id: courseData['id'] as String,
              title: courseData['title'] as String,
              image: courseData['image'] as String,
              progress: courseData['progress'] as double,
              isEnrolled: true,
            ))
        .toList();

    if (mounted) {
      setState(() {
        _myCourses = enrolledCourses;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Courses'),
        backgroundColor: AppColors.primary,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _myCourses.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.school_outlined,
                        size: 80,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'You haven\'t enrolled in any courses yet',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Enroll in courses to start learning',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AllCoursesPage(),
                            ),
                          ).then((_) => _loadEnrolledCourses());
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Browse Courses'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadEnrolledCourses,
                  child: ListView.builder(
                    itemCount: _myCourses.length,
                    itemBuilder: (context, index) {
                      final course = _myCourses[index];
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                                    // Progress Bar
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
                                ),
                              ),
                              // Arrow Icon for details
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                color: Colors.grey,
                                onPressed: () {
                                  // Navigate to course detail
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
