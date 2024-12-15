import 'package:flutter/material.dart';
import '../../service/product_service.dart';
import '../model/product.dart';

class UpdateProductScreen extends StatefulWidget {
  static const String name = '/update_product_screen';
  final Product product;

  const UpdateProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  // Controllers
  late final Map<String, TextEditingController> _controllers;

  // Service
  final ProductService _productService = ProductService();

  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // State
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing product data
    _controllers = {
      'name': TextEditingController(text: widget.product.productName ?? ''),
      'price': TextEditingController(text: widget.product.unitPrice ?? ''),
      'totalPrice': TextEditingController(text: widget.product.totalPrice ?? ''),
      'quantity': TextEditingController(text: widget.product.quantity ?? ''),
      'image': TextEditingController(text: widget.product.image ?? ''),
      'code': TextEditingController(text: widget.product.productCode ?? ''),
    };
  }

  @override
  void dispose() {
    // Dispose all controllers
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  void _updateProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final productData = {
      "Img": _controllers['image']!.text.trim(),
      "ProductCode": _controllers['code']!.text.trim(),
      "ProductName": _controllers['name']!.text.trim(),
      "Qty": _controllers['quantity']!.text.trim(),
      "TotalPrice": _controllers['totalPrice']!.text.trim(),
      "UnitPrice": _controllers['price']!.text.trim()
    };

    final success = await _productService.updateProduct(widget.product.id ?? '', productData);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      _showSnackBar('Product updated successfully', isError: false);
      Navigator.pop(context, true);
    } else {
      _showSnackBar('Failed to update product', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Update Product'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildProductForm(),
        ),
      ),
    );
  }

  Widget _buildProductForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(
            controller: _controllers['name']!,
            label: 'Product Name',
            hint: 'Name',
            validator: _validateRequired,
          ),
          _buildTextField(
            controller: _controllers['price']!,
            label: 'Product Price',
            hint: 'Price',
            validator: _validateRequired,
          ),
          _buildTextField(
            controller: _controllers['quantity']!,
            label: 'Product Quantity',
            hint: 'Quantity',
            validator: _validateRequired,
          ),
          _buildTextField(
            controller: _controllers['totalPrice']!,
            label: 'Product Total Price',
            hint: 'Total Price',
            validator: _validateRequired,
          ),
          _buildTextField(
            controller: _controllers['code']!,
            label: 'Product Code',
            hint: 'Code',
            validator: _validateRequired,
          ),
          _buildTextField(
            controller: _controllers['image']!,
            label: 'Product Image',
            hint: 'Image URL',
            validator: _validateRequired,
          ),
          const SizedBox(height: 16),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hint,
          labelText: label,
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildSubmitButton() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ElevatedButton(
      onPressed: _updateProduct,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
      child: const Text(
        'Update Product',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  String? _validateRequired(String? value) {
    return (value?.trim().isEmpty ?? true) ? 'This field is required' : null;
  }
}