import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_learn/core/app_colors.dart';
import 'package:smart_learn/models/course.dart';
import 'package:smart_learn/screens/all_courses_page.dart';
import 'package:smart_learn/screens/login_screen.dart';
import 'package:smart_learn/screens/my_courses_page.dart';
import 'package:smart_learn/screens/course_details_page.dart';
import 'package:smart_learn/screens/settings_page.dart';
import 'package:smart_learn/services/course_service.dart';
import 'package:smart_learn/services/student_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StudentService _studentService = StudentService();
  final CourseService _courseService = CourseService();
  String _studentName = 'Student';
  bool _isLoading = true;
  bool _isLoadingCourses = true;
  int _selectedIndex = 0;
  List<Course> _enrolledCourses = [];
  List<Course> _allCourses = [];

  @override
  void initState() {
    super.initState();
    _loadStudentInfo();
    _loadCourses();
  }

  // Load student information when page initializes
  Future<void> _loadStudentInfo() async {
    try {
      final name = await _studentService.getStudentName();
      
      if (mounted) {
        setState(() {
          _studentName = name;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading student info: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Load courses for the home page
  Future<void> _loadCourses() async {
    setState(() {
      _isLoadingCourses = true;
    });

    try {
      // Get enrolled course IDs
      final enrolledCourseIds = await _courseService.getEnrolledCourses();

      // Sample course data
      final coursesData = [
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
      ];

      // Convert to Course objects
      List<Course> allCourses = coursesData.map((course) => 
        Course(
          id: course['id'] as String,
          title: course['title'] as String,
          image: course['image'] as String,
          progress: course['progress'] as double,
          isEnrolled: enrolledCourseIds.contains(course['id']),
        )
      ).toList();

      // Filter for enrolled courses
      List<Course> enrolled = allCourses.where((course) => course.isEnrolled).toList();

      if (mounted) {
        setState(() {
          _allCourses = allCourses;
          _enrolledCourses = enrolled;
          _isLoadingCourses = false;
        });
      }
    } catch (e) {
      print('Error loading courses: $e');
      if (mounted) {
        setState(() {
          _isLoadingCourses = false;
        });
      }
    }
  }

  // Get first two words of the student name
  String _getShortName() {
    final nameParts = _studentName.split(' ');
    if (nameParts.length > 1) {
      return '${nameParts[0]} ${nameParts[1]}';
    }
    return _studentName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Welcome Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        elevation: 4.0,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_isLoading ? "Loading..." : _studentName),
              accountEmail: null, // Removed email display
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home,
                  color: Colors.blueAccent),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.school,
                  color: Colors.deepPurple),
              title: Text('My Courses'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyCoursesPage(),
                  ),
                ).then((_) => _loadCourses());
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.bookmark, color: Colors.teal),
              title: Text('Saved Notes'),
              onTap: () {
                print("Settings clicked");
              },
            ),
            ListTile(
              leading: Icon(Icons.folder_copy_rounded,
                  color: Colors.orangeAccent),
              title: Text('My Materials'),
              onTap: () {
                print("Settings clicked");
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,
                  color: Colors.grey.shade700),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const SettingsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info,
                  color: Colors.indigoAccent),
              title: Text('About'),
              onTap: () {
                print("About clicked");
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout,
                  color: Colors.redAccent),
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),

      backgroundColor: const Color(0xFFE9DED3),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _loadCourses();
            await _loadStudentInfo();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildSearchBar(),
                const SizedBox(height: 16),
                _buildCategories(),
                const SizedBox(height: 16),
                _buildSectionTitle('All Courses', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AllCoursesPage()),
                  ).then((_) => _loadCourses());
                }),
                const SizedBox(height: 8),
                _buildCourseList(_allCourses, false),
                const SizedBox(height: 16),
                _buildSectionTitle('My Courses', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyCoursesPage()),
                  ).then((_) => _loadCourses());
                }),
                const SizedBox(height: 8),
                _buildCourseList(_enrolledCourses, true),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      // Add bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          
          // Handle navigation based on selected index
          switch(index) {
            case 0: // Home - already on home, do nothing
              break;
            case 1: // Courses
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyCoursesPage()),
              );
              break;
            case 2: // Profile/Settings
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
              break;
          }
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Header widget
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _isLoading ? 'Welcome Student' : 'Welcome ${_getShortName()}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  // Search bar widget
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.search,
              color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Here',
                hintStyle: TextStyle(
                    color: AppColors.textSecondary),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Categories widget
  Widget _buildCategories() {
    final categories = [
      'CSE332',
      'CSE441',
      'MAT226',
      'GED111'
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionTitle(
      String title, VoidCallback onSeeAllPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        TextButton(
          onPressed: onSeeAllPressed,
          child: Text(
            'See All',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Course list widget
  Widget _buildCourseList(List<Course> courses, bool isEnrolledList) {
    if (_isLoadingCourses) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    if (courses.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Column(
            children: [
              Icon(
                isEnrolledList ? Icons.school_outlined : Icons.menu_book,
                size: 48,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 8),
              Text(
                isEnrolledList 
                  ? 'No enrolled courses yet' 
                  : 'No available courses',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              if (isEnrolledList)
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllCoursesPage(),
                      ),
                    ).then((_) => _loadCourses());
                  },
                  child: const Text('Browse courses to enroll'),
                ),
            ],
          ),
        ),
      );
    }
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: courses.map((course) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsPage(
                    title: course.title,
                  ),
                ),
              );
            },
            child: Container(
              width: 160,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.asset(
                      course.image,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: course.progress,
                            backgroundColor: Colors.grey[200],
                            color: AppColors.primary,
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 4),
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
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
