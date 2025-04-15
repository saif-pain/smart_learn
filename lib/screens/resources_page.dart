import 'package:flutter/material.dart';
import 'package:smart_learn/core/app_colors.dart';
import 'package:smart_learn/screens/questions.dart';
import 'package:smart_learn/screens/home_screen.dart';
import 'package:smart_learn/screens/course_details_page.dart'; // Added import for CourseDetailsPage
import 'package:url_launcher/url_launcher.dart';

class ResourcesPage extends StatefulWidget {
  final String title;
  
  const ResourcesPage({Key? key, required this.title}) : super(key: key);

  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  final List<bool> _isExpandedList = [true, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            // Return to home screen instead of previous screen
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCourseBanner(),
            _buildTabBar(),
            const SizedBox(height: 16),
            _buildResourcesList(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseBanner() {
    String bannerImage = 'assets/images/onboarding1.png';
    
    // Select appropriate banner image based on course title
    if (widget.title.toLowerCase().contains('mobile')) {
      bannerImage = 'assets/images/MAD.png';
    } else if (widget.title.toLowerCase().contains('compiler')) {
      bannerImage = 'assets/images/compiler.png';
    } else if (widget.title.toLowerCase().contains('math')) {
      bannerImage = 'assets/images/mat.png';
    } else if (widget.title.toLowerCase().contains('physics')) {
      bannerImage = 'assets/images/phy.png';
    }
    
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            image: DecorationImage(
              image: AssetImage(bannerImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabItem('Overview', isSelected: false, onTap: () {
            // Navigate to CourseDetailsPage (Overview) and specify it's not coming from home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CourseDetailsPage(
                  title: widget.title,
                  fromHome: false, // Specify this navigation is not from home
                ),
              ),
            );
          }),
          _buildTabItem('Resources', isSelected: true, onTap: () {}),
          _buildTabItem('Questions', isSelected: false, onTap: () {
            // Navigate to QuestionsPage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QuestionsPage(
                  title: widget.title,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, {required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 50,
              color: AppColors.primary,
            ),
        ],
      ),
    );
  }

  Widget _buildResourcesList() {
    // Get resources specific to the course
    final resources = _getResourcesForCourse(widget.title);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Course Resources',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Access helpful resources to enhance your learning experience',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: resources.length,
            itemBuilder: (context, categoryIndex) {
              final category = resources[categoryIndex];
              return _buildResourceCategory(
                category['title'] as String,
                List<Map<String, dynamic>>.from(category['resources'] as List),
                isExpanded: _isExpandedList.length > categoryIndex ? _isExpandedList[categoryIndex] : false,
                onExpansionChanged: (isExpanded) {
                  if (categoryIndex < _isExpandedList.length) {
                    setState(() {
                      _isExpandedList[categoryIndex] = isExpanded;
                    });
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCategory(
    String title,
    List<Map<String, dynamic>> resources,
    {required bool isExpanded,
    required ValueChanged<bool> onExpansionChanged,}
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: resources.map((resource) {
          return _buildResourceItem(
            title: resource['title'] as String,
            description: resource['description'] as String,
            url: resource['url'] as String,
            type: resource['type'] as String,
          );
        }).toList(),
        onExpansionChanged: onExpansionChanged,
        initiallyExpanded: isExpanded,
      ),
    );
  }

  Widget _buildResourceItem({
    required String title,
    required String description,
    required String url,
    required String type,
  }) {
    IconData icon;
    Color iconColor;
    
    // Choose icon based on resource type
    switch (type) {
      case 'pdf':
        icon = Icons.picture_as_pdf;
        iconColor = Colors.red;
        break;
      case 'video':
        icon = Icons.play_circle_outline;
        iconColor = Colors.red;
        break;
      case 'link':
        icon = Icons.language;
        iconColor = Colors.blue;
        break;
      case 'book':
        icon = Icons.menu_book;
        iconColor = Colors.green;
        break;
      case 'code':
        icon = Icons.code;
        iconColor = Colors.purple;
        break;
      default:
        icon = Icons.article;
        iconColor = AppColors.primary;
    }
    
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
        size: 30,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        description,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.open_in_new),
        onPressed: () async {
          final Uri uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Could not launch resource'),
              ),
            );
          }
        },
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  // Returns resources specific to the course title
  List<Map<String, dynamic>> _getResourcesForCourse(String courseTitle) {
    // Default resources for any course
    final List<Map<String, dynamic>> defaultResources = [
      {
        'title': 'E-Books & PDFs',
        'resources': [
          {
            'title': 'Introduction to the Subject',
            'description': 'A comprehensive PDF guide introducing the fundamentals',
            'url': 'https://openstax.org/subjects',
            'type': 'pdf'
          },
          {
            'title': 'Practice Exercises',
            'description': 'Collection of practice problems with solutions',
            'url': 'https://www.academia.edu/',
            'type': 'pdf'
          },
        ]
      },
      {
        'title': 'Video Tutorials',
        'resources': [
          {
            'title': 'Course Introduction',
            'description': 'A comprehensive introduction to the course topics',
            'url': 'https://www.youtube.com/results?search_query=introduction+to+college+courses',
            'type': 'video'
          },
          {
            'title': 'Problem-Solving Techniques',
            'description': 'Learn essential problem-solving methods for this subject',
            'url': 'https://www.youtube.com/results?search_query=academic+problem+solving',
            'type': 'video'
          },
        ]
      },
      {
        'title': 'Online Resources',
        'resources': [
          {
            'title': 'Interactive Learning Modules',
            'description': 'Practice with interactive modules and quizzes',
            'url': 'https://www.khanacademy.org/',
            'type': 'link'
          },
          {
            'title': 'Academic Forum Discussions',
            'description': 'Join discussions related to this course topic',
            'url': 'https://www.reddit.com/r/AskAcademia/',
            'type': 'link'
          },
        ]
      },
    ];
    
    // Course-specific resources based on title
    if (courseTitle.toLowerCase().contains('mobile') || courseTitle.toLowerCase().contains('app')) {
      return [
        {
          'title': 'Mobile Development Fundamentals',
          'resources': [
            {
              'title': 'Flutter Documentation',
              'description': 'Official Flutter documentation for building beautiful applications',
              'url': 'https://docs.flutter.dev/',
              'type': 'link'
            },
            {
              'title': 'Android Developer Guides',
              'description': 'Official Android development resources and documentation',
              'url': 'https://developer.android.com/guide',
              'type': 'link'
            },
            {
              'title': 'iOS Development with Swift',
              'description': 'Learn to build iOS applications with Swift programming language',
              'url': 'https://developer.apple.com/swift/',
              'type': 'link'
            },
          ]
        },
        {
          'title': 'UI/UX Design Resources',
          'resources': [
            {
              'title': 'Material Design Guidelines',
              'description': 'Google\'s design system for creating high-quality digital experiences',
              'url': 'https://m3.material.io/',
              'type': 'link'
            },
            {
              'title': 'Mobile UI Design Patterns',
              'description': 'Common UI design patterns and when to use them',
              'url': 'https://www.youtube.com/watch?v=XZYQBrW3Q40',
              'type': 'video'
            },
            {
              'title': 'Figma Mobile App Design',
              'description': 'Tutorial on designing mobile apps using Figma',
              'url': 'https://www.youtube.com/watch?v=PeGfX7W1mJk',
              'type': 'video'
            },
          ]
        },
        {
          'title': 'Sample Code & Projects',
          'resources': [
            {
              'title': 'Flutter Sample Apps',
              'description': 'Collection of sample Flutter applications and code patterns',
              'url': 'https://github.com/flutter/samples',
              'type': 'code'
            },
            {
              'title': 'Android Architecture Components',
              'description': 'Sample code for Android architecture components',
              'url': 'https://github.com/android/architecture-components-samples',
              'type': 'code'
            },
          ]
        },
      ];
    } else if (courseTitle.toLowerCase().contains('compiler')) {
      return [
        {
          'title': 'Compiler Design Fundamentals',
          'resources': [
            {
              'title': 'Compiler Design Basics',
              'description': 'Introduction to compiler design principles and phases',
              'url': 'https://www.geeksforgeeks.org/compiler-design-tutorials/',
              'type': 'link'
            },
            {
              'title': 'Parsing Techniques',
              'description': 'Comprehensive guide to parsing techniques in compiler design',
              'url': 'https://en.wikipedia.org/wiki/Parsing',
              'type': 'link'
            },
            {
              'title': 'Lexical Analysis Explained',
              'description': 'Video tutorial on lexical analysis in compiler construction',
              'url': 'https://www.youtube.com/watch?v=TG0qRDrUPpA',
              'type': 'video'
            },
          ]
        },
        {
          'title': 'Implementation Resources',
          'resources': [
            {
              'title': 'Building a Compiler with LLVM',
              'description': 'Tutorial on creating a compiler using LLVM infrastructure',
              'url': 'https://llvm.org/docs/tutorial/index.html',
              'type': 'link'
            },
            {
              'title': 'Flex & Bison Tutorial',
              'description': 'Guide to using Flex and Bison for lexical analysis and parsing',
              'url': 'https://www.youtube.com/watch?v=54bo1qaHAfk',
              'type': 'video'
            },
            {
              'title': 'Writing a Simple Parser',
              'description': 'Step-by-step guide to writing a simple parser from scratch',
              'url': 'https://ruslanspivak.com/lsbasi-part1/',
              'type': 'link'
            },
          ]
        },
        {
          'title': 'Advanced Topics',
          'resources': [
            {
              'title': 'Code Optimization Techniques',
              'description': 'Advanced compiler optimization strategies and algorithms',
              'url': 'https://www.cs.cornell.edu/courses/cs6120/2020fa/self-guided/',
              'type': 'link'
            },
            {
              'title': 'Type Systems & Type Checking',
              'description': 'Understanding type systems and implementation of type checking',
              'url': 'https://www.youtube.com/watch?v=ywSZ5cUD_g8',
              'type': 'video'
            },
          ]
        },
      ];
    } else if (courseTitle.toLowerCase().contains('math')) {
      return [
        {
          'title': 'Mathematics Fundamentals',
          'resources': [
            {
              'title': 'Khan Academy Math',
              'description': 'Comprehensive tutorials covering various math topics',
              'url': 'https://www.khanacademy.org/math',
              'type': 'link'
            },
            {
              'title': 'Mathematics Textbooks',
              'description': 'Free mathematics textbooks for various levels',
              'url': 'https://openstax.org/subjects/math',
              'type': 'book'
            },
            {
              'title': '3Blue1Brown: Essence of Linear Algebra',
              'description': 'Visual and intuitive explanations of linear algebra concepts',
              'url': 'https://www.youtube.com/playlist?list=PLZHQObOWTQDPD3MizzM2xVFitgF8hE_ab',
              'type': 'video'
            },
          ]
        },
        {
          'title': 'Problem-Solving Resources',
          'resources': [
            {
              'title': 'Mathematics Problem Database',
              'description': 'Collection of problems with detailed solutions',
              'url': 'https://www.mathsisfun.com/puzzles/',
              'type': 'link'
            },
            {
              'title': 'Interactive Calculus Problems',
              'description': 'Practice calculus with interactive examples',
              'url': 'https://www.wolframalpha.com/examples/mathematics/calculus-and-analysis',
              'type': 'link'
            },
          ]
        },
        {
          'title': 'Advanced Topics',
          'resources': [
            {
              'title': 'Abstract Algebra',
              'description': 'Introduction to group theory and abstract algebra',
              'url': 'https://www.youtube.com/playlist?list=PLi01XoE8jYoi3SgnnGorR_XOW3IcK-TP6',
              'type': 'video'
            },
            {
              'title': 'Real Analysis',
              'description': 'Comprehensive guide to real analysis fundamentals',
              'url': 'https://www.math.ucdavis.edu/~hunter/intro_analysis_pdf/intro_analysis.pdf',
              'type': 'pdf'
            },
          ]
        },
      ];
    } else if (courseTitle.toLowerCase().contains('data communication') || courseTitle.toLowerCase().contains('network')) {
      return [
        {
          'title': 'Networking Fundamentals',
          'resources': [
            {
              'title': 'Introduction to Computer Networks',
              'description': 'Overview of computer network concepts and architecture',
              'url': 'https://www.geeksforgeeks.org/computer-network-tutorials/',
              'type': 'link'
            },
            {
              'title': 'OSI Model Explained',
              'description': 'Detailed explanation of the 7-layer OSI model',
              'url': 'https://www.youtube.com/watch?v=LANW3m7UgWs',
              'type': 'video'
            },
            {
              'title': 'TCP/IP Protocol Suite',
              'description': 'Comprehensive guide to the TCP/IP protocol suite',
              'url': 'https://www.tutorialspoint.com/data_communication_computer_network/tcp_ip_model.htm',
              'type': 'link'
            },
          ]
        },
        {
          'title': 'Data Transmission Concepts',
          'resources': [
            {
              'title': 'Data Transmission Basics',
              'description': 'Fundamentals of data transmission in communication networks',
              'url': 'https://www.cs.umd.edu/~meesh/cmsc411/website/projects/outer/datacommunication.htm',
              'type': 'link'
            },
            {
              'title': 'Signal Encoding Techniques',
              'description': 'Various signal encoding methods in data communication',
              'url': 'https://www.youtube.com/watch?v=bHIsfMCQ5ks',
              'type': 'video'
            },
          ]
        },
        {
          'title': 'Network Security',
          'resources': [
            {
              'title': 'Introduction to Network Security',
              'description': 'Fundamentals of securing computer networks',
              'url': 'https://www.cisco.com/c/en/us/products/security/what-is-network-security.html',
              'type': 'link'
            },
            {
              'title': 'Cryptography in Networks',
              'description': 'Application of cryptographic techniques in network security',
              'url': 'https://www.youtube.com/watch?v=1BJuuUxCaaY',
              'type': 'video'
            },
          ]
        },
      ];
    }
    
    return defaultResources;
  }
}