import 'package:flutter/material.dart';
import 'package:nexus/auth_service.dart';
import 'package:nexus/homePage.dart';

class Loginpage extends StatefulWidget {
  final void Function()? onTap;
  const Loginpage({super.key, required this.onTap});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();

    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _email.dispose();
    _password.dispose();
  }

  void login() async {
    try {
      final email = _email.text;
      final password = _password.text;
      await AuthService().login(email, password);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } on InvalidCredentialException {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Invalid Credential'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ok'),
            ),
          ],
        ),
      );
    } on InvalidEmailException {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Invalid Email'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ok'),
            ),
          ],
        ),
      );
    } on GerneralException {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Unexpexted Error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ok'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(0, 0, 0, 20),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 90),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.lock_open,
                size: 100,
                color: Color.fromARGB(255, 255, 72, 0),
              ),
              SizedBox(height: 30),
              Text(
                "Welcome You have been missed!",
                style: TextStyle(
                  color: const Color.fromARGB(255, 168, 168, 168),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 30),

              TextField(
                controller: _email,
                style: TextStyle(color: Colors.white, fontSize: 17),
                cursorColor: Color.fromARGB(255, 255, 69, 0),
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 100, 100, 100),
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 20, 20, 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 40, 40, 40),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 255, 72, 0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _password,
                style: TextStyle(color: Colors.white, fontSize: 17),
                cursorColor: Color.fromARGB(255, 255, 69, 0),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 100, 100, 100),
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 20, 20, 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 40, 40, 40),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 255, 72, 0),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 20, 20, 20),
                  borderRadius: BorderRadius.circular(13),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 1),

                child: TextButton(
                  onPressed: () {
                    login();
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 72, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'not register yet?',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 253, 253),
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
