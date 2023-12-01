class CartItem {
  final int id;
  final String product_id;
  final String product_name;
  final String product_image_url;
  final int quantity;
  final double price;
  final double sub_total;
  final int service_id;
  final String service_name;
  final int category_id;
  final String category_name;
  final double total;
  final String price_type;

  CartItem(
      {required this.id,
      required this.product_id,
      required this.product_name,
      required this.product_image_url,
      required this.quantity,
      required this.price,
      required this.sub_total,
      required this.service_id,
      required this.service_name,
      required this.category_id,
      required this.category_name,
      required this.total,
      required this.price_type});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': product_id,
      'product_name': product_name,
      'product_image_url': product_image_url,
      'quantity': quantity,
      'price': price,
      'sub_total': sub_total,
      'service_id': service_id,
      'service_name': service_name,
      'category_id': category_id,
      'category_name': category_name,
      'total': total,
      'price_type': price_type,
    };
  }

  static CartItem fromJson(Map<String, dynamic> json) {
    return CartItem(
        id: json['id'],
        product_id: json['product_id'],
        product_name: json['product_name'],
        product_image_url: json['product_image_url'],
        quantity: json['quantity'],
        price: json['price'],
        sub_total: json['sub_total'],
        service_id: json['service_id'],
        service_name: json['service_name'],
        category_id: json['category_id'],
        category_name: json['category_name'],
        total: json['total'],
        price_type: json['price_type']);
  }
}
