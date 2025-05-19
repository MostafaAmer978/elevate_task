
import 'package:elevate_task/features/screen_products/data_source_layer/model/products_model.dart';
import 'package:elevate_task/features/screen_products/domain_layer/repository/products_repository.dart';

class ProductsUseCase {
  ProductsRepository productsRepository;

  ProductsUseCase({required this.productsRepository});

  Future<List<ProductsModel>> getProducts() => productsRepository.getProducts();
}
