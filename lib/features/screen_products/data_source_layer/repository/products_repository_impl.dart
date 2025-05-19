import 'package:elevate_task/features/screen_products/data_source_layer/data_source/remote/products_remote_ds_impl.dart';
import 'package:elevate_task/features/screen_products/data_source_layer/model/products_model.dart';
import 'package:elevate_task/features/screen_products/domain_layer/repository/products_repository.dart';


class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRemoteDsImpl productsRemoteDsImpl;

  ProductsRepositoryImpl({required this.productsRemoteDsImpl});

  @override
  Future<List<ProductsModel>> getProducts() {
    return productsRemoteDsImpl.getProducts();
  }
}
