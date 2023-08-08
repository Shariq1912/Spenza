import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_product_list_data.freezed.dart';
part 'user_product_list_data.g.dart';


@freezed
class UserProductData with _$UserProductData {
  const factory UserProductData({
    required String productId

})= _UserProductData;

  factory UserProductData.fromJson(Map<String, dynamic> json) => _$UserProductDataFromJson(json);
}

