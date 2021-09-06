# sqlite
 We store data about a book and that class has 3 fields id, name and price.
https://github.com/Varanasi-Software-Junction/sqlite/blob/bbc6cf6c5368505cd95f3ae5a5a5443039e7fd40/lib/book.dart
Here is the relevant code
class Book {
  final int id;
  final String name;
  final int price;

  Book(this.id, this.name, this.price) {}

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

// Implement toString to make it easier to see information about
// each book.
  @override
  String toString() {
    return 'Book{id: $id, name: $name, price: $price}';
  }
}

Then we have the initialize method that initiaizes the database. The code is in the file
https://github.com/Varanasi-Software-Junction/sqlite/blob/bbc6cf6c5368505cd95f3ae5a5a5443039e7fd40/lib/databasehandler.dart


static void initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Function to open the database file and store a reference.
    database = openDatabase(
      /* Set the path to the database. Using the `join` function from the
       `path` package  sets the correct path for each platform.
       */
      join(await getDatabasesPath(), 'books_database.db'),
      // When the database is first created, create a table to store books.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE books(id INTEGER PRIMARY KEY, name TEXT, price INTEGER)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

Method insertBook
// Define a function that inserts books into the database
  static Future<void> insertBook(Book book) async {
    // Get a reference to the database.
    final db = await database;

    /* Insert the book into the correct table. You might also specify the
     `conflictAlgorithm` to use in case the same book is inserted twice. This cn therefore be used
     for update as well. Other values are abort,ignore,fail and rollback
     In this case, replace any previous data.*/
    await db.insert(
      'books',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

 
 Method books
 // A method that retrieves all the books from the books table.
  static Future<List<Book>> books() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The books.
    final List<Map<String, dynamic>> maps = await db.query('books');

    // Convert the List<Map<String, dynamic> into a List<Book>.
    return List.generate(maps.length, (i) {
      return Book(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['price'],
      );
    });
  }
 
  static Future<void> updateBook(Book book) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given book.
    await db.update(
      'books',
      book.toMap(),
      // Ensure that the book has a matching id.
      where: 'id = ?',
      // Pass the book's id as a whereArg to prevent SQL injection.
      whereArgs: [book.id],
    );
  }
 
 
   static Future<void> deleteBook(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the book from the database.
    await db.delete(
      'books',
      // Use a `where` clause to delete a specific book.
      where: 'id = ?',
      // Pass the book's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
 
 
 
   static void printBooks() async {
    // Create a book and add it to the books table

    // Now, use the method above to retrieve all the books.

    print(await DatabaseHandler.books()); // Prints a list that include book.

    // Update book's price and save it to the database.
    // Prints book with price 42.

    // Delete book from the database.
  }
}
 
 Its all arranged inside a statefuk widget
https://github.com/Varanasi-Software-Junction/sqlite/blob/bbc6cf6c5368505cd95f3ae5a5a5443039e7fd40/lib/vsjsqlite.dart
 
 
 Lastly, its all called from the main.dart file
 
 
 https://github.com/Varanasi-Software-Junction/sqlite/blob/bbc6cf6c5368505cd95f3ae5a5a5443039e7fd40/lib/main.dart
The SQlite is initialized fom the main itself.
 
 void main() async {
  await DatabaseHandler.initialize();
  runApp(VsjSqlite());
}

