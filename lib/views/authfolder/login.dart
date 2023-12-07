import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:assignment_test/bussinessLogic/LoginCubit/login_cubit.dart';
import 'package:assignment_test/dataModel/loginModel.dart';
import 'package:assignment_test/repositery/authrepositery/loginRepositery.dart';

class LoginTab extends StatefulWidget {
  LoginTab({Key? key}) : super(key: key);

  @override
  _LoginTabState createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginRepository()),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          // ... your existing listener code
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    // Toggle password visibility
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await context.read<LoginCubit>().postLoginData(Login(
                          username: _usernameController.text,
                          password: _passwordController.text,
                        ));
                  } catch (e) {
                    print("LoginButton onPressed error - $e");
                  }
                },
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text('Login'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
