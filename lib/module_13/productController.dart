import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_from_practice_widget/module_13/utils/urls.dart';

import 'model/productModel.dart';

class ProductController {
  List<Data> products = [];
  bool isLoading = true;

  Future fetchProducts() async {
    final response = await http.get(Uri.parse(Urls.readProduct));

    if (response.statusCode == 200) {
      isLoading = false;
      final data = jsonDecode(response.body);

      ProductModel model = ProductModel.fromJson(data);
      products = model.data ?? [];
    }
  }

  Future<bool> createProduct(Data data) async {
    final response = await http.post(
      Uri.parse(Urls.createProduct),
      headers: {
        'Content-Type' : 'application/json'
      },
      body: jsonEncode({
        "ProductName": data.productName,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": data.img,
        "Qty": data.qty,
        "UnitPrice": data.unitPrice,
        "TotalPrice": data.totalPrice,
      }),
    );

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteProduct(String ProductId) async {
    final response = await http.get(Uri.parse(Urls.deleteProduct(ProductId)));
    print(Urls.deleteProduct(ProductId));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}