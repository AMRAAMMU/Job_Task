import 'package:flutter/material.dart';
import 'package:job_task/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Product Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.thumbnail),
            SizedBox(height: 16.0),
            Text(
              product.title,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Description: ${product.description}'),
            SizedBox(height: 8.0),
            Text('Price: \$${product.price.toStringAsFixed(2)} USD'),
            SizedBox(height: 8.0),
            Text('Discount Percentage: ${product.discountPercentage}%'),
            SizedBox(height: 8.0),
            Text('Rating: ${product.rating}'),
            SizedBox(height: 8.0),
            Text('Stock: ${product.stock}'),
            SizedBox(height: 8.0),
            Text('Brand: ${product.brand}'),
          ],
        ),
      ),
    );
  }
}
