import 'package:flutter/material.dart';

import '../model/product.dart';
import '../screens/update_product_screen.dart';

class ProductItem extends StatelessWidget {
  Product product;
  VoidCallback? onDeleteTab;
  ProductItem({required this.product, this.onDeleteTab});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Image(
          height: 100,
          width: 70,
          image: NetworkImage('${product.image}'),
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error);
          },
        ),
        title: Text(product.productName ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product Code: ${product.productCode ?? ''}'),
            Text('Quantity:  ${product.quantity ?? ''}'),
            Text('Price:  ${product.unitPrice ?? ''}'),
            Text('Total Price:  ${product.totalPrice ?? ''}'),
          ],
        ),
        trailing: Wrap(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  UpdateProductScreen.name,
                  arguments: product,
                );
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: onDeleteTab,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        tileColor: Colors.white,
      ),
    );
  }
}
