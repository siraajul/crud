
import 'package:flutter/material.dart';
import '../../service/product_service.dart';
import '../model/product.dart';
import 'add_product_screen.dart';
import '../widget/Shimmer_ProductList.dart';
import '../widget/product_item.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductService _productService = ProductService();
  List<Product> _productList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final products = await _productService.fetchProducts();
      setState(() {
        _productList = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar('Failed to load products');
    }
  }

  Future<void> _deleteProduct(Product product, int index) async {
    final confirmed = await _showDeleteConfirmation(product);

    if (confirmed) {
      final success = await _productService.deleteProduct(product.id ?? '');

      if (success) {
        setState(() {
          _productList.removeAt(index);
        });
        _showSuccessSnackBar('Product deleted');
      } else {
        _showErrorSnackBar('Failed to delete product');
      }
    }
  }

  Future<bool> _showDeleteConfirmation(Product product) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete ${product.productName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    ) ?? false;
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadProducts,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, AddProductScreen.name),
          ),
        ],
      ),
      body: _isLoading
          ? const ShimmerProductList()
          : RefreshIndicator(
        onRefresh: _loadProducts,
        child: ListView.builder(
          itemCount: _productList.length,
          itemBuilder: (context, index) {
            final product = _productList[index];
            return ProductItem(
              product: product,
              onDeleteTab: () => _deleteProduct(product, index),
            );
          },
        ),
      ),
    );
  }
}