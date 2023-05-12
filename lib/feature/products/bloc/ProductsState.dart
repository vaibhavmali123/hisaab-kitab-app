import 'package:equatable/equatable.dart';
import 'package:hisab_kitab/feature/products/model/ProductsModel.dart';
class ProductsState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];

  const ProductsState();
}
class ProductsInitial extends ProductsState{

}

class ProductsLoadingState extends ProductsState{

}
class ProductsLoadedState extends ProductsState{
  final ProductsModel productsModel;

  ProductsLoadedState(this.productsModel);
}

class ProductsError extends ProductsState{

  final String message;

  ProductsError(this.message);
}