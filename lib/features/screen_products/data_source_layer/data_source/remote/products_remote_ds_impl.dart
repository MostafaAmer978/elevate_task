import 'package:dio/dio.dart';
import 'package:elevate_task/core/api_manager/api_manager.dart';
import 'package:elevate_task/core/api_manager/end_points.dart';
import 'package:elevate_task/features/screen_products/data_source_layer/data_source/remote/products_remote_ds.dart';
import 'package:elevate_task/features/screen_products/data_source_layer/model/products_model.dart';

class ProductsRemoteDsImpl implements ProductsRemoteDs {
  ApiManager apiManager;

  ProductsRemoteDsImpl({required this.apiManager});

  @override
  Future<List<ProductsModel>> getProducts() async {
    try{
      apiManager = ApiManager();
      Response response = await apiManager.get(EndPoints.products);
      List<dynamic> productsList = response.data;
      List<ProductsModel> productsModel = productsList.map((product) => ProductsModel.fromJson(product)).toList();
      return productsModel;
    }catch(error){
      throw Exception("Failed to Call ApiManager => ${error.toString()}");
    }
  }
}
