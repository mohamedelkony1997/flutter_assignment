import 'package:assignment_test/dataModel/loginModel.dart';
import 'package:assignment_test/repositery/authrepositery/loginRepositery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../bussinessLogic/cubit/login_cubit.dart';

class LoginTab extends StatelessWidget {
  LoginTab({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginRepository()),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            Get.snackbar("Message", "Checking Internet connection",
                snackPosition: SnackPosition.TOP);
          } else if (state is LoginSuccess) {
            Get.snackbar("Message", "Login successful",
                snackPosition: SnackPosition.TOP);
          } else if (state is LoginFailure) {
            Get.snackbar("Message", "Login failed: ${state.error}",
                snackPosition: SnackPosition.TOP);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Username",
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
