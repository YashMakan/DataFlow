import 'package:dataflow/dataflow.dart';
import 'package:example/store.dart';
import 'package:flutter/material.dart';

import 'actions.dart';
import 'todo_widget.dart';

class LoginScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 36),
            DataSync<AppStore>(
                disableErrorBuilder: true,
                actions: const {LoginAction},
                actionNotifier: {
                  LoginAction: (context, action, status) {
                    if (status == DataActionStatus.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(action.error.toString()),
                        ),
                      );
                    } else if (status == DataActionStatus.success) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => TodoScreen()),
                      );
                    }
                  }
                },
                builder: (context, store, hasData) {
                  return ElevatedButton(
                    onPressed: () {
                      LoginAction(
                          usernameController.text, passwordController.text);
                    },
                    child: const Text('Login'),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
