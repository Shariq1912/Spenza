import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spenza/utils/color_utils.dart';

class UserSelectedProductCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String priceRange;

  const UserSelectedProductCard({
    required this.imageUrl,
    required this.title,
    required this.priceRange,
  });

  @override
  _UserSelectedProductCardState createState() =>
      _UserSelectedProductCardState();
}

class _UserSelectedProductCardState extends State<UserSelectedProductCard> {
  int quantity = 1;

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: widget.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'KG',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.priceRange,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              GestureDetector(
                onTap: _decreaseQuantity,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text(
                    "-",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color to white
                  border: Border.all(color: Colors.black.withOpacity(0.3)),
                ),
                child: Text(
                  quantity.toString(),
                  style: TextStyle(fontSize: 16, color: ColorUtils.colorPrimary),
                ),
              ),
              SizedBox(width: 4),
              GestureDetector(
                onTap: _increaseQuantity,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text(
                    "+",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
