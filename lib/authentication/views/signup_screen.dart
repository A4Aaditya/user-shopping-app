import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/authentication/bloc/auth_bloc.dart';
import 'package:new_user_shop_app/dashboard/dashboard_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _globalKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailNameController = TextEditingController();
  final _passwordNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup Screen'),
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            const SizedBox(height: 16),
            TextFormField(
              controller: _firstNameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'First Name',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _lastNameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Last Name',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailNameController,
              validator: (value) => validateEmail(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Email',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordNameController,
              validator: (value) => validatePassword(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Password',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
              if (state is AuthSuccess) {
                // Navigate to Home Screen
                navigateToDashboard();
              } else if (state is AuthError) {
                // Show SnackBar
                showSnackBar(message: state.message, color: Colors.red);
              }
            }, builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                onPressed: signupPressed,
                child: const Text('Signup'),
              );
            })
          ],
        ),
      ),
    );
  }

  void signupPressed() async {
    final email = _emailNameController.text.trim();
    final password = _passwordNameController.text.trim();
    if (_globalKey.currentState?.validate() == true) {
      final bloc = context.read<AuthBloc>();
      final event = AuthSignupEvent(email: email, password: password);
      bloc.add(event);
    }
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

  String? validateEmail() {
    final email = _emailNameController.text.trim();
    if (email.isEmpty) {
      return 'Please enter email';
    } else if (EmailValidator.validate(email) == false) {
      return 'Please enter correct email';
    }
    return null;
  }

  String? validatePassword() {
    final password = _passwordNameController.text.trim();
    if (password.isEmpty) {
      return 'Please enter password';
    } else if (password.length < 6) {
      return 'Password should be atleast 6 character';
    }
    return null;
  }
}
