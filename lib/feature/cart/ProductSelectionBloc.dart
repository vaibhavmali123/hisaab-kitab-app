import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisab_kitab/feature/cart/CartEvent.dart';
import 'package:hisab_kitab/feature/cart/CartState.dart';

import 'CartModel.dart';
class ProductSelectionBloc extends Bloc<CartEvent,CartState>{

  List<CartModel>cartList=[];
  List<dynamic>cartIds=[];

  ProductSelectionBloc():super(CartInitialState()){

    on<RemoveFromCartEvent>(removeFromCart);
    on<AddToCartEvent>(addToCart);
    on<UpdateQuantity>(updateQuantity);
    on<ClearCartEvent>(clearCart);
    on<LoadCartEvent>(loadCart);
  }

  FutureOr<void> removeFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    for(int i=0;i<cartList.length;i++){
      if(event.cartModel.productId==cartList[i].productId){
        if(cartList[i].quantity>0) {
          print("CART quantity from if ${event.cartModel.quantity}");
          cartList[i].quantity = --cartList[i].quantity;
          if(cartList[i].quantity==0){
            cartList.remove(cartList[i]);
          }
        }
        else if(event.cartModel.quantity<=1){
          print("CART quantity from else if ${event.cartModel.quantity}");
          cartList.remove(cartList[i]);
        }
        break;
      }
    }
    print("CART AFTER REMOVED ${cartList.length}");
    emit(ProductsSelectionState(cartList));
  }
  FutureOr<void> addToCart(AddToCartEvent event, Emitter<CartState> emit)
  {
    if(cartList.isNotEmpty){
      final index=cartList.indexOf(event.cartModel);
      for(int i=0;i<cartList.length;i++){
        if(event.cartModel.productId==cartList[i].productId) {
        cartList[i].quantity=++cartList[i].quantity;
        cartIds.add(cartList[i].productId);
            print("CART WHILE add form if ${event.cartModel.productId} ${cartList[i].quantity}");
            break;
        }
        else if(event.cartModel.productId!=cartList[i].productId){
          print("CART WHILE add form else ${event.cartModel.productId} ${event.cartModel.quantity}");
          //cartList.add(event.cartModel);
        }
      }
      if(!cartIds.contains(event.cartModel.productId)){
        cartList.add(event.cartModel);
      }
    }
    else{
      cartList.add(event.cartModel);
    }
    print("CART AFTER added ${cartList.length}");
    emit(ProductsSelectionState(cartList));
  }
  FutureOr<void> updateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    final index=cartList.indexOf(event.cartModel);

    for(int i=0;i<cartList.length;i++){

      if(event.cartModel.productId==cartList[i].productId) {
        cartList[i].quantity=cartList[i].quantity+1;
      }
      else{
        cartList.add(event.cartModel);
      }
    }
    emit(ProductsSelectionState(cartList));
  }
  FutureOr<void> clearCart(ClearCartEvent event, Emitter<CartState> emit) {
    cartList.clear();
    cartIds.clear();
    print("AFTER CART CLEAR ${cartList.length}");
    emit(ProductsSelectionState(cartList));
  }

  FutureOr<void> loadCart(LoadCartEvent event, Emitter<CartState> emit) {
    print("AFTER CART LOAD ${cartList.length}");
    emit(ProductsSelectionState(cartList));
  }
}