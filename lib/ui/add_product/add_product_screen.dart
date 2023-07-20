import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/ui/add_product/components/product_card_widget.dart';
import 'package:spenza/ui/add_product/components/product_card_widget.dart';
import 'package:spenza/ui/my_list_details/components/custom_app_bar.dart';
import 'package:spenza/ui/my_list_details/components/searchbox_widget.dart';
import 'package:spenza/utils/color_utils.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  ConsumerState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final poppinsFont = ref.watch(poppinsFontProvider).fontFamily;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          displayActionIcon: false,
          title: 'Add Product',
          textStyle: TextStyle(
            fontFamily: poppinsFont,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: ColorUtils.colorPrimary,
          ),
          onBackIconPressed: () {
            context.pop();
          },
        ),
        body: ListView(
          children: [
            SearchBox(
              hint: "Search product",
              controller: _searchController,
              onChanged: (value) {},
            ),
            const SizedBox(height: 10),

            ProductCard(
              imageUrl: 'https://picsum.photos/250?image=9',
              title: 'Product 1',
              priceRange: "\$10.00 - \$20.15",
            ),
            ProductCard(
              imageUrl: 'https://picsum.photos/250?image=9',
              title: 'Product 2',
              priceRange: "\$10.00 - \$20.15",
            ),
            // Add more CustomCard widgets here for other items
          ],
        ),
      ),
    );
  }
}
