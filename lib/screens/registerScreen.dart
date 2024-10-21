import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/userController.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget{
    const RegisterScreen({super.key});

    @override 
    _RegisterScreenState createState() => _RegisterScreenState(); 
}

class _RegisterScreenState extends State<RegisterScreen>{
    final _formularioKey = GlobalKey<FormState>();
    final UserController controller = Get.put(UserController());

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                title: const Text("Registro"),
            ),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: _formularioKey,
                    child: Column(
                        children: [
                            TextFormField(
                                controller: controller.nameController,
                                decoration: const InputDecoration(labelText: 'Name'),
                                validator: (value) {
                                    if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                    }
                                    return null;
                                },
                            ),
                            TextFormField(
                                controller: controller.emailController,
                                decoration: const InputDecoration(labelText: 'Email'),
                                validator: (value) {
                                    if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                    }
                                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))  {
                                        return 'Please enter a valid email';
                                    }
                                    return null;
                                },
                            ),
                            TextFormField(
                                controller: controller.passwordController,
                                decoration: const InputDecoration(labelText: 'Password'),
                                validator: (value) {
                                    if(value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                    }
                                    if (value.length < 6) {
                                        return 'Password must have at least 6 characters';
                                    }
                                    return null;
                                },
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                                onPressed: () {
                                    if (_formularioKey.currentState!.validate()) {
                                        Navigator.pushNamed(context, '/login');
                                    }else{
                                        const Text('Alguma excessão ocorreu');
                                    }
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
