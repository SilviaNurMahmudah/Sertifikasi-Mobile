import 'package:flutter/material.dart';

import '../services/db_helper.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool> login() async {
    return await DataHelper()
        .authUser(_usernameController.text, _passwordController.text);
  }

  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 50.0),
              Image.asset(
                'piggy.png',
                height: 150.0,
                width: 150.0,
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "MyCashBook V1.0",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  contentPadding: const EdgeInsets.only(
                      left: 30.0, top: 20.0, bottom: 20.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  prefixIcon: const Icon(Icons.person, color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: _isHidePassword,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  contentPadding: const EdgeInsets.only(
                      left: 30.0, top: 20.0, bottom: 20.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: () {
                    _togglePasswordVisibility();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Show Password'),
                      Icon(
                        _isHidePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color:
                            _isHidePassword ? Colors.grey[600] : Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  primary: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  (_usernameController.text == "" ||
                          _passwordController.text == "")
                      ? showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text(
                                  'Username atau Password tidak boleh kosong'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        )
                      : login().then(
                          (value) {
                            if (value) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text(
                                        'Username atau Password salah'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        );
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
