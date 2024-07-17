import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  // Dummy user data
  Map<String, String> _users = {};

  void _signIn() {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // Simulate a login delay
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        String email = _emailController.text.trim();
        String password = _passwordController.text.trim();
        if (_users.containsKey(email) && _users[email] == password) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => QuizScreen()),
          );
        } else {
          _errorMessage = 'Sign in failed. Please check your credentials.';
          _isLoading = false;
        }
      });
    });
  }

  void _goToSignUp() async {
    final Map<String, String>? newUsers = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SignUpScreen(users: _users)),
    );

    if (newUsers != null) {
      setState(() {
        _users = newUsers;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'QUIZ APP',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: _signIn,
                        child: Text('Sign In'),
                      ),
                      TextButton(
                        onPressed: _goToSignUp,
                        child: Text('Don\'t have an account? Sign Up'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  final Map<String, String> users;

  SignUpScreen({required this.users});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  void _signUp() {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // Simulate a sign-up delay
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        String email = _emailController.text.trim();
        String password = _passwordController.text.trim();
        if (widget.users.containsKey(email)) {
          _errorMessage = 'Sign up failed. User already exists.';
          _isLoading = false;
        } else {
          widget.users[email] = password;
          Navigator.of(context).pop(widget.users);
        }
      });
    });
  }

  void _goToSignIn() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: _signUp,
                        child: Text('Sign Up'),
                      ),
                      TextButton(
                        onPressed: _goToSignIn,
                        child: Text('Back to Sign In'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final _questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Paris', 'London', 'Rome', 'Berlin'],
      'answer': 'Paris',
    },
    {
      'question': 'Who wrote "To Kill a Mockingbird"?',
      'options': [
        'Harper Lee',
        'Mark Twain',
        'Ernest Hemingway',
        'F. Scott Fitzgerald'
      ],
      'answer': 'Harper Lee',
    },
    {
      'question': 'What is the largest planet in our solar system?',
      'options': ['Earth', 'Mars', 'Jupiter', 'Saturn'],
      'answer': 'Jupiter',
    },
    {
      'question': 'What is the chemical symbol for water?',
      'options': ['H2O', 'O2', 'CO2', 'NaCl'],
      'answer': 'H2O',
    },
    {
      'question': 'Who painted the Mona Lisa?',
      'options': [
        'Vincent van Gogh',
        'Pablo Picasso',
        'Leonardo da Vinci',
        'Claude Monet'
      ],
      'answer': 'Leonardo da Vinci',
    },
    {
      'question': 'Which country is known as the Land of the Rising Sun?',
      'options': ['China', 'Japan', 'South Korea', 'India'],
      'answer': 'Japan',
    },
    {
      'question': 'What is the smallest prime number?',
      'options': ['0', '1', '2', '3'],
      'answer': '2',
    },
    {
      'question': 'Who is the author of the Harry Potter series?',
      'options': [
        'J.R.R. Tolkien',
        'J.K. Rowling',
        'George R.R. Martin',
        'C.S. Lewis'
      ],
      'answer': 'J.K. Rowling',
    },
    {
      'question': 'What is the boiling point of water?',
      'options': ['90°C', '100°C', '110°C', '120°C'],
      'answer': '100°C',
    },
    {
      'question': 'What is the hardest natural substance on Earth?',
      'options': ['Gold', 'Iron', 'Diamond', 'Platinum'],
      'answer': 'Diamond',
    },
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;

  void _answerQuestion(String answer) {
    if (answer == _questions[_currentQuestionIndex]['answer']) {
      _score++;
    }
    setState(() {
      _currentQuestionIndex++;
    });
  }

  void _goToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _currentQuestionIndex < _questions.length
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _questions[_currentQuestionIndex]['question'] as String,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 20),
                  ...(_questions[_currentQuestionIndex]['options']
                          as List<String>)
                      .map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ElevatedButton(
                        onPressed: () => _answerQuestion(option),
                        child: Text(option),
                      ),
                    );
                  }).toList(),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Quiz Completed!',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Text(
                      'Your score is $_score/${_questions.length}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentQuestionIndex = 0;
                          _score = 0;
                        });
                      },
                      child: Text('Restart Quiz'),
                    ),
                    ElevatedButton(
                      onPressed: _goToHome,
                      child: Text('Go back to Home'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
