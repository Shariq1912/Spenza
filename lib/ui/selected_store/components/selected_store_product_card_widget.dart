import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spenza/utils/color_utils.dart';

class SelectedStoreProductCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  final String measure;
  final int quantity;
  final VoidCallback onClick;
  final bool isMissing;

  const SelectedStoreProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.measure,
    required this.quantity,
    required this.isMissing,
    required this.onClick,
  }) : super(key: key);

  @override
  _SelectedStoreProductCardState createState() =>
      _SelectedStoreProductCardState();
}

class _SelectedStoreProductCardState extends State<SelectedStoreProductCard> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        child: InkWell(
          onTap: () {
            setState(() {
              _isSelected = !_isSelected;
            });
            widget.onClick.call();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.quantity} pza",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),

                    /*if (!widget.isMissing) ...[
                      Text(
                        "${widget.quantity} pza",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                    if (widget.isMissing) ...[
                      Text(
                        "${widget.measure == "kg" ? "1 kg" : widget.measure}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ]*/
                  ],
                ),
                SizedBox(width: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        widget.title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "\$ ${widget.price.toStringAsFixed(2)} / ${widget.measure}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: _isSelected,
                        onChanged: (_) {
                          setState(() {
                            _isSelected = !_isSelected;
                          });
                        },
                        // Background color of your checkbox if selected
                        activeColor: ColorUtils.colorPrimary,
                        // Color of your check mark
                        checkColor: Colors.white,
                        shape: CircleBorder(),
                        side: BorderSide(
                          // ======> CHANGE THE BORDER COLOR HERE <======
                          color: ColorUtils.colorPrimary,
                          // Give your checkbox border a custom width
                          width: 1.5,
                        ),
                      ),
                    ),
                    Text(
                      "\$ ${(widget.price * widget.quantity).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
