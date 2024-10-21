import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/databaseHelper.dart';
import 'package:flutter_application_1/models/userModel.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class UserController extends GetxController {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

  // Getter parar acessar o banco de dados
  Future<Database> get _database async {
    return await DataBaseHelper.instance.database;

  }

  // Inserir um novo usuário no banco de dados
  Future<int> insertUser(String name, String email, String password) async {
    final db = await _database;
    return await db.insert('users', {
      'name': name,
      'email': email,
      'password': password,
    });
  }

  // Atualizar um usuário existente
  Future<int> updateUser(User user) async {
    final db = await _database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await _database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
