import 'package:flutter/material.dart';
import 'package:promp_flutter_final/model/login.dart';

import '../service/auth.dart';

class NewAccountScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService _service = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Account"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      hintText: "Email", icon: Icon(Icons.people))),
              const SizedBox(height: 10),
              TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "Password", icon: Icon(Icons.lock))),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    bool res = await _service.register(
                        _emailController.text, _passwordController.text);
                    if (res) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Account has been created")));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }
                  },
                  child: const Text("Create"))
            ],
          ),
        ));
  }
}
