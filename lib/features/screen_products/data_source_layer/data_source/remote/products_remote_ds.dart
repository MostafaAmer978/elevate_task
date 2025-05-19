import 'package:elevate_task/features/screen_products/data_source_layer/model/products_model.dart';

abstract class ProductsRemoteDs {
  Future<List<ProductsModel>> getProducts();
}
