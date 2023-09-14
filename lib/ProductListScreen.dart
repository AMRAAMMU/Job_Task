import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:job_task/ProductDetailsScreen.dart';
import 'package:job_task/product_model.dart';
import 'api_service.dart';

class ProductListScreen extends StatefulWidget {
  final List<Product> products;

  ProductListScreen({required this.products});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];
  List<Product> filteredProducts = [];
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    try {
      final fetchedProducts = await ApiService.fetchProducts();
      setState(() {
        products = fetchedProducts;
        filteredProducts = products;
      });
    } catch (e) {

    }
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = products;
      } else{
        filteredProducts = products
            .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: isSearching
            ? TextField(
          controller: searchController,
          onChanged: (query) {
            _filterProducts(query);
          },
          decoration: InputDecoration(
            hintText: 'Search products...',
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white),
        )
            : Text(
          'Product List',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: isSearching ? Icon(Icons.cancel) : Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                  _filterProducts('');
                }
              });
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            return ListTile(
              leading: CachedNetworkImage(
                imageUrl: product.thumbnail,
                placeholder: (context, url) =>
                    CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              title: Text(product.title),
              subtitle: Text('${product.price.toStringAsFixed(2)} USD'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(product: product),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
