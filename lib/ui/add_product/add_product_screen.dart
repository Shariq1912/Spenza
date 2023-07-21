import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/ui/add_product/components/product_card_widget.dart';
import 'package:spenza/ui/add_product/components/product_card_widget.dart';
import 'package:spenza/ui/add_product/provider/add_product_provider.dart';
import 'package:spenza/ui/my_list_details/components/custom_app_bar.dart';
import 'package:spenza/ui/my_list_details/components/searchbox_widget.dart';
import 'package:spenza/utils/color_utils.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key, required this.query});

  final String query;

  @override
  ConsumerState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    print("Query is ${widget.query}");
    Future.microtask(() =>
        ref.read(addProductProvider.notifier).searchProducts(
            query: widget.query));
    }

  @override
  Widget build(BuildContext context) {
    final poppinsFont = ref
        .watch(poppinsFontProvider)
        .fontFamily;

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
        body: Consumer(
          builder: (context, ref, child) =>
              ref.watch(addProductProvider).when(
                data: (data) =>
                    ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> product = data[index];
                        return ListTile(
                          title: Text(product['name']),
                          subtitle: Text(product['department']),
                          // Display other product information as needed
                        );
                      },
                    ),
                error: (error, stackTrace) => Center(child: Text("$error")),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
        ),
      ),
    );
  }
}
