import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_learn/screens/login_screen.dart';
import 'package:smart_learn/services/student_service.dart';

class TopicsPage extends StatefulWidget {
  const TopicsPage({Key? key}) : super(key: key);

  @override
  State<TopicsPage> createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  final StudentService _studentService = StudentService();
  String _studentName = 'Student';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudentInfo();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9DED3),
      appBar: AppBar(
        title: const Text(
          "Topics",
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
              leading: const Icon(Icons.home,
                  color: Colors.blueAccent),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.school,
                  color: Colors.deepPurple),
              title: const Text('My Courses'),
              onTap: () {
                print("Settings clicked");
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.bookmark, color: Colors.teal),
              title: const Text('Saved Notes'),
              onTap: () {
                print("Settings clicked");
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder_copy_rounded,
                  color: Colors.orangeAccent),
              title: const Text('My Materials'),
              onTap: () {
                print("Settings clicked");
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,
                  color: Colors.grey.shade700),
              title: const Text('Settings'),
              onTap: () {
                print("Settings clicked");
              },
            ),
            ListTile(
              leading: const Icon(Icons.info,
                  color: Colors.indigoAccent),
              title: const Text('About'),
              onTap: () {
                print("About clicked");
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout,
                  color: Colors.redAccent),
              title: const Text('Logout'),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Explore by topics',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildTopicsGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search, color: Colors.blue),
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Here',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle filter action
            },
            child: const Text(
              'Filter',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicsGrid() {
    final topics = [
      {'title': 'Data Communication', 'color': Colors.blue},
      {
        'title': 'Basic Electronics',
        'color': Colors.orange
      },
      {'title': 'Basic Mathematics', 'color': Colors.green},
      {
        'title': 'Electrical Circuits',
        'color': Colors.purple
      },
      {'title': 'Art Of Living', 'color': Colors.red},
    ];

    return Expanded(
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3 / 2,
        ),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          return GestureDetector(
            onTap: () {
              // Handle topic selection
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  // Placeholder container instead of image
                  Container(
                    color: topic['color'] as Color,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  // Title text
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Text(
                      topic['title'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
