import 'package:cooking_tutorial_application/screens/start/screens/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import '../components/components.dart';
import '../components/under_part.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const nameRoute = '/loginpage';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _passwordInVisible = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _firebaseLoginAuth() async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            )
            .then((value) => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text(
                      'Login was succesful!',
                      style: TextStyle(fontSize: 20),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: const Text('Explore'),
                        onPressed: () {
                          const Duration(milliseconds: 500);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UserPreferencesPage()));
                        },
                      ),
                    ],
                  );
                }));
      } on FirebaseAuthException catch (e) {
        showNotification(context, e.message.toString());
      }
      setState(() {
        loading = false;
      });
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
                const PageTitleBar(title: 'Hello, Welcome Back'),
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
                          "Login below with your details",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'OpenSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 15,
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
                                        Icons.person,
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
                              const SizedBox(
                                height: 10,
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
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          ForgotPasswordPage.nameRoute);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Text('Forgot Password?',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              loading
                                  ? const CircularProgressIndicator()
                                  : RoundedButton(
                                      text: 'LOGIN',
                                      press: () async {
                                        _firebaseLoginAuth();
                                      }),
                              const SizedBox(
                                height: 10,
                              ),
                              UnderPart(
                                title: "Don't have an account?",
                                navigatorText: "Register here",
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()));
                                },
                              ),
                              const SizedBox(
                                height: 20,
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
