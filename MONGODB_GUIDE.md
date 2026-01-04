# MongoDB Example Usage

## How to Use MongoDB in Your Flutter App

### 1. Set Your Password
Edit the `.env` file and replace `your_actual_password_here` with your actual MongoDB password.

### 2. Install Dependencies
Run: `flutter pub get`

### 3. Example Usage

```dart
import 'package:ios26_testing/services/mongodb_service.dart';

// Get the MongoDB service instance
final mongoService = MongoDBService.instance;

// Insert a document
await mongoService.insert('users', {
  'name': 'John Doe',
  'email': 'john@example.com',
  'age': 30,
});

// Find documents
final users = await mongoService.find('users');
print(users);

// Find one document
final user = await mongoService.findOne('users', {
  'email': 'john@example.com',
});

// Update a document
await mongoService.update(
  'users',
  {'email': 'john@example.com'},
  {'age': 31},
);

// Delete a document
await mongoService.delete('users', {
  'email': 'john@example.com',
});
```

### 4. Access from Any Screen

```dart
import 'package:ios26_testing/services/mongodb_service.dart';

class MyScreen extends StatelessWidget {
  Future<void> loadData() async {
    final data = await MongoDBService.instance.find('my_collection');
    // Use your data
  }
  
  // ... rest of your widget
}
```

## Security Note
- Never commit the `.env` file to version control
- Add `.env` to your `.gitignore` file
- For production, consider using a backend API instead of direct database connection
