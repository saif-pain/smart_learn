import 'package:flutter/material.dart';
import 'package:smart_learn/core/app_colors.dart';
import 'package:smart_learn/models/semester_result_model.dart';
import 'package:smart_learn/models/student_model.dart';
import 'package:smart_learn/screens/semester_results_page.dart';
import 'package:smart_learn/services/result_service.dart';

class AcademicResultsPage extends StatefulWidget {
  const AcademicResultsPage({Key? key}) : super(key: key);

  @override
  State<AcademicResultsPage> createState() => _AcademicResultsPageState();
}

class _AcademicResultsPageState extends State<AcademicResultsPage> {
  final _formKey = GlobalKey<FormState>();
  final _studentIdController = TextEditingController();
  String? _selectedSemesterId;
  bool _isLoading = false;
  bool _isFetchingStudentInfo = false;
  bool _isLoadingSemesters = false;
  String? _errorMessage;
  Student? _studentInfo;
  List<Map<String, dynamic>> _semesters = [];
  
  final ResultService _resultService = ResultService();

  @override
  void dispose() {
    _studentIdController.dispose();
    super.dispose();
  }
  
  // Fetch student information when student ID changes
  Future<void> _fetchStudentInfo() async {
    final studentId = _studentIdController.text;
    if (studentId.isEmpty) return;
    
    setState(() {
      _isFetchingStudentInfo = true;
      _errorMessage = null;
      _studentInfo = null;
      _semesters = [];
    });
    
    try {
      final student = await _resultService.fetchStudentInfo(studentId);
      
      if (mounted) {
        setState(() {
          _studentInfo = student;
          _isFetchingStudentInfo = false;
        });
        
        // After successfully fetching student info, load available semesters
        _loadAvailableSemesters();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to fetch student information. Please check your student ID.';
          _isFetchingStudentInfo = false;
        });
      }
    }
  }
  
  // Load available semesters for the student
  Future<void> _loadAvailableSemesters() async {
    setState(() {
      _isLoadingSemesters = true;
    });
    
    try {
      final semesters = await _resultService.fetchAvailableSemesters();
      
      if (mounted) {
        setState(() {
          _semesters = semesters;
          _isLoadingSemesters = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load semesters. Please try again.';
          _isLoadingSemesters = false;
        });
      }
    }
  }

  Future<void> _viewResults() async {
    if (_formKey.currentState!.validate() && _selectedSemesterId != null) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        // Get results from API service using the semester ID
        final SemesterResult semesterResult = await _resultService.fetchSemesterResults(
          _studentIdController.text,
          _selectedSemesterId!,
        );

        if (!mounted) return;

        // Navigate to semester results page with the fetched data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SemesterResultsPage(
              semesterResult: semesterResult,
              studentInfo: _studentInfo,
            ),
          ),
        );
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to load results. Please try again.';
        });
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else if (_selectedSemesterId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a semester'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Academic Results',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Check Your Results',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your student ID and select a semester to view your academic results.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              
              // Error message
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red[300]!),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red[700]),
                        ),
                      ),
                    ],
                  ),
                ),
              
              // Student information display
              if (_studentInfo != null)
                _buildStudentInfoCard(),
              
              const SizedBox(height: 16),
              _buildResultsForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentInfoCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _studentInfo!.studentName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ID: ${_studentInfo!.studentId}',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          _infoRow('Program:', _studentInfo!.progShortName),
          _infoRow('Department:', _studentInfo!.departmentName),
          _infoRow('Batch:', 'Batch ${_studentInfo!.batchNo}'),
          _infoRow('Current Semester:', _studentInfo!.semesterName),
        ],
      ),
    );
  }
  
  // Helper method to display information rows
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Student ID TextField
          const Text(
            'Student ID',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _studentIdController,
                  decoration: InputDecoration(
                    hintText: 'Enter your student ID',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your student ID';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _isFetchingStudentInfo ? null : _fetchStudentInfo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isFetchingStudentInfo
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Verify'),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Semester Dropdown
          const Text(
            'Semester',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: _isLoadingSemesters
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    value: _selectedSemesterId,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.blue,
                      ),
                    ),
                    hint: const Text('Select semester'),
                    isExpanded: true,
                    items: _semesters.map((semester) {
                      return DropdownMenuItem<String>(
                        value: semester['id'],
                        child: Text(semester['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSemesterId = value;
                      });
                    },
                  ),
                ),
          ),
          
          const SizedBox(height: 40),
          
          // View Results Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isLoading || _studentInfo == null || _semesters.isEmpty ? null : _viewResults,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBackgroundColor: Colors.blue.withOpacity(0.5),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'View Results',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}