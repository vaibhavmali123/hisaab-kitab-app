import 'package:equatable/equatable.dart';
import 'package:hisab_kitab/feature/products/model/ProductsModel.dart';

class CartEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

  CartEvent();
}
class ProductsSelectedEvent extends CartEvent{
  final List<ProductsList>productsCartList;

  ProductsSelectedEvent(this.productsCartList);
}