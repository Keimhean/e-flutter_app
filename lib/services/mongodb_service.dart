import 'package:flutter/foundation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MongoDBService {
  static MongoDBService? _instance;
  static Db? _db;

  MongoDBService._();

  static MongoDBService get instance {
    _instance ??= MongoDBService._();
    return _instance!;
  }

  // URL encode password to handle special characters
  static String _encodePassword(String password) {
    return Uri.encodeComponent(password);
  }

  Future<void> connect() async {
    if (_db != null && _db!.isConnected) {
      debugPrint('MongoDB already connected');
      return;
    }

    try {
      final String password = dotenv.env['MONGODB_PASSWORD'] ?? '';
      final String encodedPassword = _encodePassword(password);
      final String username = 'hounkeumhean_db_user';

      final String connectionString =
          'mongodb+srv://$username:$encodedPassword@keimhean.2vrsqn4.mongodb.net/app_db?retryWrites=true&w=majority';

      debugPrint('Attempting to connect to MongoDB...');
      debugPrint('Username: $username');
      debugPrint(
        'Database URI: mongodb+srv://$username:***@keimhean.2vrsqn4.mongodb.net/app_db',
      );

      _db = await Db.create(connectionString);
      await _db!.open();

      debugPrint('Connected to MongoDB successfully');
    } catch (e) {
      debugPrint('Error connecting to MongoDB: $e');
      debugPrint('Stack trace: ${StackTrace.current}');
      rethrow;
    }
  }

  Future<void> close() async {
    if (_db != null && _db!.isConnected) {
      await _db!.close();
      debugPrint('MongoDB connection closed');
    }
  }

  Db? get database => _db;

  DbCollection getCollection(String collectionName) {
    if (_db == null || !_db!.isConnected) {
      throw Exception('Database not connected. Call connect() first.');
    }
    return _db!.collection(collectionName);
  }

  // Example CRUD operations
  Future<Map<String, dynamic>?> findOne(
    String collectionName,
    Map<String, dynamic> query,
  ) async {
    try {
      final collection = getCollection(collectionName);
      return await collection.findOne(query);
    } catch (e) {
      debugPrint('Error finding document: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> find(
    String collectionName, {
    Map<String, dynamic>? query,
    int? limit,
  }) async {
    try {
      final collection = getCollection(collectionName);

      var cursor = collection.find(query);
      if (limit != null) {
        cursor = cursor.take(limit);
      }

      return await cursor.toList();
    } catch (e) {
      debugPrint('Error finding documents: $e');
      return [];
    }
  }

  Future<bool> insert(
    String collectionName,
    Map<String, dynamic> document,
  ) async {
    try {
      final collection = getCollection(collectionName);
      await collection.insert(document);
      return true;
    } catch (e) {
      debugPrint('Error inserting document: $e');
      return false;
    }
  }

  Future<bool> insertMany(
    String collectionName,
    List<Map<String, dynamic>> documents,
  ) async {
    try {
      final collection = getCollection(collectionName);
      await collection.insertAll(documents);
      return true;
    } catch (e) {
      debugPrint('Error inserting documents: $e');
      return false;
    }
  }

  Future<bool> update(
    String collectionName,
    Map<String, dynamic> query,
    Map<String, dynamic> update,
  ) async {
    try {
      final collection = getCollection(collectionName);
      await collection.update(query, update);
      return true;
    } catch (e) {
      debugPrint('Error updating document: $e');
      return false;
    }
  }

  Future<bool> delete(String collectionName, Map<String, dynamic> query) async {
    try {
      final collection = getCollection(collectionName);
      await collection.remove(query);
      return true;
    } catch (e) {
      debugPrint('Error deleting document: $e');
      return false;
    }
  }

  // Test connection method
  Future<bool> testConnection() async {
    try {
      if (_db == null || !_db!.isConnected) {
        return false;
      }
      // Try to list database names to verify connection
      await _db!.getCollectionNames();
      return true;
    } catch (e) {
      debugPrint('Connection test failed: $e');
      return false;
    }
  }
}
