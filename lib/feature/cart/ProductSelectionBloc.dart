import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisab_kitab/feature/cart/CartEvent.dart';
import 'package:hisab_kitab/feature/cart/CartState.dart';
class ProductSelectionBloc extends Bloc<CartEvent,CartState>{

  ProductSelectionBloc():super(CartInitialState()){

    on<ProductsSelectedEvent>((event,emit){
      try{
          emit(ProductsSelectionState(event.productsCartList));
        print("PRODDDDD ${event.productsCartList[0].productName}");
        print("PRODDDDD length from bloc: ${event.productsCartList.length.toString()}");

      }
      finally{
        emit(ProductsSelectionState(event.productsCartList));
        print("PRODDDDD ${event.productsCartList[0].productName}");
      }
    });
  }
}