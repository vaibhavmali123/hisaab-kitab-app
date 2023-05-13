import 'package:equatable/equatable.dart';
import 'package:hisab_kitab/feature/products/model/ProductsModel.dart';

class CartState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

  CartState();
}

class CartInitialState extends CartState{

}

class ProductsSelectionState extends CartState{
  final List<ProductsList>productsCartList;

   ProductsSelectionState(this.productsCartList);
}