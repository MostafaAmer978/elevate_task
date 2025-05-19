import 'package:elevate_task/features/screen_products/data_source_layer/model/products_model.dart';
import 'package:elevate_task/features/screen_products/domain_layer/usecase/products_use_case.dart';
import 'package:elevate_task/features/screen_products/presentation_layer/cubit/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsUseCase productsUseCase;
  List<ProductsModel> productsModel = [];

  ProductsCubit({required this.productsUseCase})
    : super(ProductsInitialsState());

  void getProducts() async {
    try {
      emit(ProductsLoadingState());
      List<ProductsModel> products = await productsUseCase.getProducts();
      productsModel = products;
      emit(ProductsSuccessState());
    } catch (error) {
      throw Exception("Failed to Call ApiManager => ${error.toString()}");
    }
  }
}
