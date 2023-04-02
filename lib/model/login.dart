import 'package:flutter/material.dart';
import 'package:promp_flutter_final/main.dart';
import 'package:promp_flutter_final/model/new_account.dart';
import 'package:promp_flutter_final/service/auth.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService _service = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Reminder App"),
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
                    bool res = await _service.login(
                        _emailController.text, _passwordController.text);
                    if (res) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("You've been logged in")));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                    title: 'Reminder App',
                                  )));
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Failed")));
                    }
                  },
                  child: const Text("Login")),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NewAccountScreen()));
                },
                child: const Text(
                  "Create Account",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
        ));
  }
}
