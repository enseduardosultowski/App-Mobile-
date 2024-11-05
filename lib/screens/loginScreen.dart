import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/loginController.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final LoginController controller = Get.put(LoginController());
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Campo de E-mail
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  } else if (!GetUtils.isEmail(value)) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),
              
              // Campo de Senha
              TextFormField(
                controller: controller.passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Botão de login
              _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Inicia o loading enquanto processa
                        setState(() {
                          _isLoading = true;
                        });

                        try {
                          bool success = await controller.loginUser();

                          if (success) {
                            // Navega para a tela principal
                            Get.offAllNamed('/home'); 
                          } else {
                            // Exibe uma mensagem de erro após um pequeno delay
                            Future.delayed(Duration.zero, () {
                              Get.snackbar(
                                'Login Failed',
                                'Invalid credentials',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            });
                          }
                        } catch (e) {
                          // Exibe uma mensagem de erro genérica caso algo dê errado
                          Future.delayed(Duration.zero, () {
                            Get.snackbar(
                              'Error',
                              'An error occurred. Please try again later.',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          });
                        } finally {
                          // Finaliza o loading
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),

              const SizedBox(height: 20),

              // Botão de registro
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
