import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import '../components/components.dart';
import '../components/under_part.dart';
import 'screens.dart';
import '../widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  static const nameRoute = '/signuppage';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  late bool _isLoading;
  bool _passwordInVisible = true;
  bool _passwordInVisible2 = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Future _createAccount() async {
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim())
            .then((value) => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text(
                      'Register was succesful!',
                      style: TextStyle(fontSize: 20),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: const Text('Okay'),
                        onPressed: () {
                          const Duration(milliseconds: 1000);
                          Navigator.pushNamed(
                              context, CompleteProfilPage.nameRoute);
                        },
                      ),
                    ],
                  );
                }));
      } on FirebaseAuthException catch (e) {
        showNotification(context, e.message.toString());
      }
    } else {
      showNotification(
          context, 'Make sure password and confirm password is match');
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent, content: Text(message.toString())));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(
                  imgUrl: "assets/bg.jpg",
                ),
                const PageTitleBar(title: 'Create Account'),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Register below with your details ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'OpenSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFieldContainer(
                                child: TextFormField(
                                  controller: _emailController,
                                  cursorColor: const Color(0xfff1bb274),
                                  decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.email,
                                        color: Color(0xfff1bb274),
                                      ),
                                      hintText: 'Email',
                                      hintStyle:
                                          TextStyle(fontFamily: 'OpenSans'),
                                      border: InputBorder.none),
                                  validator: Validators.compose([
                                    Validators.required(
                                        'Email address is required'),
                                    Validators.email('Please input valid email')
                                  ]),
                                ),
                              ),
                              TextFieldContainer(
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: _passwordInVisible,
                                  cursorColor: Color(0xfff1bb274),
                                  decoration: InputDecoration(
                                      icon: const Icon(
                                        Icons.lock,
                                        color: Color(0xfff1bb274),
                                      ),
                                      hintText: "Password",
                                      hintStyle: const TextStyle(
                                          fontFamily: 'OpenSans'),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordInVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: const Color(0xfff1bb274),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordInVisible =
                                                !_passwordInVisible;
                                          });
                                        },
                                      ),
                                      border: InputBorder.none),
                                  validator: Validators.compose([
                                    Validators.required('Password is required'),
                                  ]),
                                ),
                              ),
                              TextFieldContainer(
                                child: TextFormField(
                                  controller: _confirmPasswordController,
                                  obscureText: _passwordInVisible2,
                                  cursorColor: Color(0xfff1bb274),
                                  decoration: InputDecoration(
                                      icon: const Icon(
                                        Icons.lock,
                                        color: Color(0xfff1bb274),
                                      ),
                                      hintText: "Confirm Password",
                                      hintStyle: const TextStyle(
                                          fontFamily: 'OpenSans'),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordInVisible2
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Color(0xfff1bb274),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordInVisible2 =
                                                !_passwordInVisible2;
                                          });
                                        },
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                              RoundedButton(
                                  text: 'REGISTER',
                                  press: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _createAccount();
                                    }
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              UnderPart(
                                title: "Already have an account?",
                                navigatorText: "Login here",
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
