import 'package:flutter/material.dart';
import 'package:nexus/auth_service.dart';
import 'package:nexus/homePage.dart';

class Registerpage extends StatefulWidget {
  final void Function()? onTap;
  const Registerpage({super.key, required this.onTap});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
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

  void signup() async {
    try {
      final email = _email.text;
      final password = _password.text;
      await AuthService().register(email, password);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } on EmailAlreadyInuseException {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('email already in use '),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ok'),
            ),
          ],
        ),
      );
    } on WeakPasswordException {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('weak password'),
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
                "Welcome Please sign up to Nexus!",
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
                  onPressed: () async {
                    signup();
                  },
                  child: Text(
                    'Sign up',
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
                    'already register?',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Login',
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
