import 'package:flutter/material.dart';
import 'package:ios26_testing/services/mongodb_service.dart';

class DbTestScreen extends StatefulWidget {
  const DbTestScreen({super.key});

  @override
  State<DbTestScreen> createState() => _DbTestScreenState();
}

class _DbTestScreenState extends State<DbTestScreen> {
  String _status = 'Not tested yet';
  bool _isLoading = false;
  List<String> _collections = [];

  Future<void> _testConnection() async {
    setState(() {
      _isLoading = true;
      _status = 'Testing connection...';
    });

    try {
      final mongoService = MongoDBService.instance;

      // Test if connected
      final isConnected = await mongoService.testConnection();

      if (isConnected) {
        // Get collection names
        final db = mongoService.database;
        if (db != null) {
          final collections = await db.getCollectionNames();
          setState(() {
            _status = '✅ Connected successfully!';
            _collections = collections.whereType<String>().toList();
          });
        }
      } else {
        setState(() {
          _status = '❌ Not connected. Check your password in .env file';
        });
      }
    } catch (e) {
      setState(() {
        _status = '❌ Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testInsert() async {
    setState(() {
      _isLoading = true;
      _status = 'Testing insert...';
    });

    try {
      final success = await MongoDBService.instance.insert('test_collection', {
        'name': 'Test User',
        'email': 'test@example.com',
        'timestamp': DateTime.now().toIso8601String(),
      });

      setState(() {
        _status = success ? '✅ Insert successful!' : '❌ Insert failed';
      });
    } catch (e) {
      setState(() {
        _status = '❌ Insert error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testFind() async {
    setState(() {
      _isLoading = true;
      _status = 'Testing find...';
    });

    try {
      final documents = await MongoDBService.instance.find(
        'test_collection',
        limit: 5,
      );

      setState(() {
        _status = '✅ Found ${documents.length} documents';
      });
    } catch (e) {
      setState(() {
        _status = '❌ Find error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MongoDB Connection Test'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Connection Status:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_status, style: const TextStyle(fontSize: 16)),
                    if (_collections.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Collections in database:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ..._collections.map(
                        (col) => Padding(
                          padding: const EdgeInsets.only(left: 16, top: 4),
                          child: Text('• $col'),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _testConnection,
              icon: const Icon(Icons.wifi),
              label: const Text('Test Connection'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _testInsert,
              icon: const Icon(Icons.add),
              label: const Text('Test Insert Document'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _testFind,
              icon: const Icon(Icons.search),
              label: const Text('Test Find Documents'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
