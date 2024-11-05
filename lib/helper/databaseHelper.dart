import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static const String _databaseName = 'app_database.db';
  static const int _databaseVersion = 1;

  static final DataBaseHelper instance = DataBaseHelper._();

  static Database? _database;

  DataBaseHelper._();
  //get database é a função para "pegar" o banco de dados
  //async = assíncrona (Depende de outra variável para funcionar)
  Future<Database> get database async {

  // _database ??= await _initDatabase(); = esperando a variável da initDatabase
    _database ??= await _initDatabase();
    return _database!;
  }

  // initDatabase "abre" o banco de dados, o tornando disponível
  Future<Database> _initDatabase() async {

  //dbPath = Espera o repositório de salvamento ser definido e salva as variáveis com o nome do banco de dados definido
    final dbPath = join(await getDatabasesPath(), _databaseName);

  //Aguarda que o dbPath seja executado
    return await openDatabase(
      dbPath,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }
  // OnCreate cria as tabelas, colunas e seus tipos dentro do banco de dados já aberto
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        avatarUrl TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        price REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productid INTEGER NOT NULL,
        FOREIGN KEY (productid) REFERENCES products (id)
      )
    ''');
  }

// Fecha o banco de dados
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}