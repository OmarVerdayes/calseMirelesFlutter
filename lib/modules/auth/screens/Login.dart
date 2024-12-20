import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isObscure;
  final VoidCallback toggleVisibility;
  final String hintText; 
  final String labelText; 

  const PasswordInput({
    required this.controller,
    required this.isObscure,
    required this.toggleVisibility,
    required this.hintText,
    required this.labelText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hintText,
        label: Text(labelText), // Usamos la propiedad para la etiqueta
        suffixIcon: IconButton(
          onPressed: toggleVisibility,
          icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    final RegExp emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su correo electrónico';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Por favor, ingrese un correo electrónico válido';
    }
    return null; 
  }

  void togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Iniciar sesión"),
        backgroundColor: Colors.blue,
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 16, color: Colors.orange[900]),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo.png",
                  width: 200,
                  height: 200,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Correo electrónico",
                    label: Text("Correo electrónico"),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                const SizedBox(height: 16),
                PasswordInput(
                  controller: _passwordController,
                  isObscure: _isObscure,
                  toggleVisibility: togglePasswordVisibility,
                  hintText: "Contraseña", 
                  labelText: "Contraseña",
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                          print("Credencial: ${credential}");
                          Navigator.pushReplacementNamed(context, '/menu');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.orange[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Iniciar sesión",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/register'),
                  child: Text(
                    "Registrarase",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
