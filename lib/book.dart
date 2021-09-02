class Book {
  final int id;
  final String name;
  final int price;

  Book(
   this.id,this.name,this.price
){

  }

   Map<String, dynamic> toMap() {
  return {
  'id': id,
  'name': name,
  'price': price,
  };
  }

// Implement toString to make it easier to see information about
// each dog when using the print statement.
  @override
  String toString() {
  return 'Book{id: $id, name: $name, price: $price}';
  }
}