import 'package:elevate_task/core/api_manager/api_manager.dart';
import 'package:elevate_task/core/utils/app_colors.dart';
import 'package:elevate_task/features/screen_products/data_source_layer/data_source/remote/products_remote_ds_impl.dart';
import 'package:elevate_task/features/screen_products/data_source_layer/repository/products_repository_impl.dart';
import 'package:elevate_task/features/screen_products/domain_layer/usecase/products_use_case.dart';
import 'package:elevate_task/features/screen_products/presentation_layer/cubit/products_cubit.dart';
import 'package:elevate_task/features/screen_products/presentation_layer/cubit/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ScreenProducts extends StatelessWidget {
  const ScreenProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create:
              (context) => ProductsCubit(
                productsUseCase: ProductsUseCase(
                  productsRepository: ProductsRepositoryImpl(
                    productsRemoteDsImpl: ProductsRemoteDsImpl(
                      apiManager: ApiManager(),
                    ),
                  ),
                ),
              )..getProducts(),
          child: buildBlocBuilder(),
        ),
      ),
    );
  }

  Widget onSuccess(ProductsCubit cubit) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 200,
      ),
      itemBuilder: (context, index) {
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.blue, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildProductImage(cubit, index),
                  buildProductDetails(cubit, index),
                ],
              ),
            ),
            buildIconsFavouriteAndAdd(),
          ],
        );
      },
      itemCount: cubit.productsModel.length,
    );
  }

  Widget buildProductImage(ProductsCubit cubit, int indexProduct) {
    return Expanded(
      flex: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: Image.network(
          "${cubit.productsModel[indexProduct].image}",
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget buildProductDetails(ProductsCubit cubit, int indexProduct) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${cubit.productsModel[indexProduct].title}", maxLines: 1),
            Text(
              "${cubit.productsModel[indexProduct].description}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text("EGP ${cubit.productsModel[indexProduct].price}"),
                SizedBox(width: 8),
                Text(
                  "${(cubit.productsModel[indexProduct].price! * 1.25).toStringAsFixed(1)} EGP",
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.blue,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Review (${cubit.productsModel[indexProduct].rating?.rate})",
                ),
                Icon(Icons.star, color: AppColors.amber, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIconsFavouriteAndAdd() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.white,
            child: IconButton(
              onPressed: () {
                /// onClicked
              },
              icon: Icon(Icons.favorite_border_outlined),
              color: AppColors.blue,
            ),
          ),
          CircleAvatar(
            backgroundColor: AppColors.blue,
            child: IconButton(
              onPressed: () {
                /// onClicked
              },
              icon: Icon(Icons.add, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBlocBuilder() {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<ProductsCubit>(context);
        if (state is ProductsSuccessState) {
          return onSuccess(cubit);
        } else {
          return Center(child: CircularProgressIndicator(color: AppColors.blue));
        }
      },
    );
  }
}
