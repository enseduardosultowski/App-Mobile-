import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/databaseHelper.dart';
import 'package:flutter_application_1/models/userModel.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:convert';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  // Usando RxBool para controle de loading
  final RxBool isLoading = false.obs;

  // Função para pegar o banco de dados
  Future<Database> get database async {
    return await DataBaseHelper.instance.database;
  }

  // Função para login do usuário
  Future<bool> loginUser() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      // Mostrar erro se algum campo estiver vazio
      Get.snackbar(
        'Erro',
        'Preencha todos os campos',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    // Aqui começa a parte de login, onde verificamos as credenciais do usuário
    final user = await getUserByEmailAndPassword(email, password);

    if (user != null) {
      // Limpa os campos se o login for bem sucedido
      _clearFields();
      return true;
    } else {
      // Caso contrário, retorne false
      Get.snackbar(
        'Erro',
        'Credenciais inválidas',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  // Função para pegar o usuário pelo email e senha
  Future<User?> getUserByEmailAndPassword(String email, String password) async {
    final db = await database;

    // Hash da senha antes de consultar o banco
    final hashedPassword = _hashPassword(password);

    // Consultar o banco de dados
    final maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, hashedPassword],
    );

    if (maps.isNotEmpty) {
      // Se o usuário for encontrado, retornamos um objeto User
      return User.fromMap(maps.first);
    }
    // Caso contrário, retornamos null
    return null;
  }

  // Função privada para limpar os campos de email e senha
  void _clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  // Função para fazer o hash da senha
  String _hashPassword(String password) {
    final bytes = utf8.encode(password); // Convertendo a senha para bytes
    final digest = sha256.convert(bytes); // Criando o hash SHA256
    return digest.toString(); // Retorna o hash como string
  }
}
