// ignore_for_file: public_member_api_docs, sort_constructors_first
/// * The product identifier is an important concept and can have its own type.
typedef ProductID = String;

/// Class representing a product.
class Product {
  const Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.availableQuantity,
    this.avgRating = 0,
    this.numRatings = 0,
  });

  /// Unique product id
  final ProductID id;
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final int availableQuantity;
  final double avgRating;
  final int numRatings;

  @override
  String toString() {
    return 'Product(id: $id, imageUrl: $imageUrl, title: $title, description: $description, price: $price, availableQuantity: $availableQuantity, avgRating: $avgRating, numRatings: $numRatings)';
  }
}
