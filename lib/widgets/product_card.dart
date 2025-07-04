import 'package:flutter/material.dart';
import 'package:marketer/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.height,
    required this.product,
    required this.price,
  });

  final double height;
  final Product product;
  final String price;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white10,
          border: Border.all(width: 2, color: Colors.green),
        ),
        height: height < 300 ? 300 : height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  product.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          Container(
                            height: 150,
                            color: Colors.grey,
                            child: Icon(Icons.error),
                          ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 120,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    product.title,
                    softWrap: true,

                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
