// ignore_for_file: must_be_immutable, unused_local_variable, use_build_context_synchronously, library_private_types_in_public_api, prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project_uts/admin/beranda_admin.dart';
import 'package:project_uts/beranda.dart';
import 'package:project_uts/daftar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: FractionallySizedBox(
                      widthFactor: constraints.maxWidth < 600 ? 0.9 : 1 / 3,
                      child: Card(
                        elevation: 8.0,
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'UDB FOODS',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Icon(Icons.person),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: TextField(
                                      controller: _usernameController,
                                      decoration: InputDecoration(
                                        labelText: 'Username',
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Icon(Icons.lock),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: TextField(
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.white,
                                        suffixIcon: IconButton(
                                          icon: Icon(_obscureText
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                        ),
                                      ),
                                      obscureText: _obscureText,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () {
                                  String username = _usernameController.text;
                                  String password = _passwordController.text;

                                  if (username == "admin" && password == "admin") {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => AdminDashboard()),
                                    );
                                  } else {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomePage()),
                                    );
                                  }
                                },
                                child: Text('Login'),
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Silahkan buat ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AkunBaruPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'akun baru',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 251, 252, 252),
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
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}