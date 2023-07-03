import 'package:equatable/equatable.dart';
import 'package:hisab_kitab/feature/cart/CartModel.dart';
import 'package:hisab_kitab/feature/products/model/ProductsModel.dart';

class CartEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
  CartEvent();
}
class LoadCartEvent extends ClearCartEvent{

}
class RemoveFromCartEvent extends CartEvent{
  final CartModel cartModel;
  RemoveFromCartEvent(this.cartModel);
}
class AddToCartEvent extends CartEvent{
  final CartModel cartModel;
  AddToCartEvent(this.cartModel);
}
class UpdateQuantity extends CartEvent{
  final CartModel cartModel;
  UpdateQuantity(this.cartModel);
}
class ClearCartEvent extends CartEvent{

}