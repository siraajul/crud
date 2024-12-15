import 'dart:convert';
import 'package:http/http.dart' as http;
import '../ui/model/product.dart';

class ProductService {
  static const String _baseUrl = 'https://crud.teamrabbil.com/api/v1';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/ReadProduct'));

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return (decodedData['data'] as List)
            .map((p) => Product(
          id: p['_id'],
          productName: p['ProductName'],
          productCode: p['ProductCode'],
          quantity: p['Qty'],
          unitPrice: p['UnitPrice'],
          image: p['Img'],
          totalPrice: p['TotalPrice'],
          createdDate: p['CreatedDate'],
        ))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products');
    }
  }

  Future<bool> updateProduct(String id, Map<String, dynamic> productData) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/UpdateProduct/$id'),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(productData),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/DeleteProduct/$id'),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}