import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/my_list_details/components/custom_app_bar.dart';
import 'package:spenza/ui/my_list_details/components/searchbox_widget.dart';
import 'package:spenza/ui/my_list_details/components/user_selected_product_widget.dart';
import 'package:spenza/utils/color_utils.dart';

class MyListDetailsScreen extends ConsumerStatefulWidAget {
  const MyListDetailsScreen({super.key});

  @override
  ConsumerState createState() => _MyListDetailsScreenState();
}

class _MyListDetailsScreenState extends ConsumerState<MyListDetailsScreen> {
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
          displayActionIcon: true,
          title: 'Cool List',
          textStyle: TextStyle(
            fontFamily: poppinsFont,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: ColorUtils.colorPrimary,
          ),
          onBackIconPressed: () {
            context.pushNamed(RouteManager.addProductScreen);
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SearchBox(
                    hint: "Add products",
                    controller: _searchController,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 10),
                  UserSelectedProductCard(
                    imageUrl: 'https://picsum.photos/250?image=9',
                    title: 'Product 1',
                    priceRange: "\$10.00 - \$20.15",
                  ),
                  UserSelectedProductCard(
                    imageUrl: 'https://picsum.photos/250?image=9',
                    title: 'Product 2',
                    priceRange: "\$10.00 - \$20.15",
                  ),
                  // Add more CustomCard widgets here for other items
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                // Add your button onPressed logic here
              },
              color: Colors.blue, // Change the button color to your desired color
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white, // Change the icon color to your desired color
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white, // Change the text color to your desired color
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
