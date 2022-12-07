import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/authentication/bloc/auth_bloc.dart';
import 'package:new_user_shop_app/authentication/views/signup_screen.dart';
import 'package:new_user_shop_app/dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 24),
            TextFormField(
              controller: _emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: Theme.of(context).textTheme.headline6,
                filled: true,
                fillColor: const Color.fromARGB(255, 233, 232, 232),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 233, 232, 232),
                hintText: 'Password',
                hintStyle: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(height: 24),
            BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
              if (state is AuthSuccess) {
                // Navigate to Dashboard
                navigateToDashboard();
              } else if (state is AuthError) {
                // show snackBar

                showSnackBar(message: state.message, color: Colors.red);
              }
            }, builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: loginPressed,
                      child: const Text('Login'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Login with Google'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have account ?"),
                      TextButton(
                        onPressed: signupPressed,
                        child: const Text('Signup'),
                      )
                    ],
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  void loginPressed() async {
    if (_globalKey.currentState?.validate() == true) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final bloc = context.read<AuthBloc>();
      final event = AuthSigninEvent(email: email, password: password);
      bloc.add(event);
    }
  }

  void signupPressed() {
    final route = MaterialPageRoute(
      builder: (context) => const SignupScreen(),
    );
    Navigator.push(context, route);
  }

  void navigateToDashboard() {
    final route = MaterialPageRoute(builder: (context) => const Dashboard());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  void showSnackBar({required Color color, required String message}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
