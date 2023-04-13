import 'package:cooking_tutorial_application/screens/start/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const nameRoute = '/forgotpass';
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool loading = false;

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content:
                const Text('Password reset link sent! Please check your email'),
            actions: <Widget>[
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.nameRoute);
                  },
                  child: const Text('OK'))
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      showNotification(context, e.message.toString());
    }
  }

  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent, content: Text(message.toString())));
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Color(0xfff1bb274),
      ),
      backgroundColor: const Color(0xffecebf3),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  'Enter your email and we will send you  a password reset link'),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xfff1bb274)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xfff1bb274)),
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: Validators.compose([
                  Validators.required('Email address is required'),
                  Validators.email('Please input valid email')
                ]),
              ),
              loading
                  ? CircularProgressIndicator()
                  : MaterialButton(
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          passwordReset();
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                      color: const Color(0xfff1bb274),
                      child: const Text('Reset Password'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
