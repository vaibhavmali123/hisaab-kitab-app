import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisab_kitab/feature/products/bloc/ProductsEvent.dart';
import 'package:hisab_kitab/feature/products/bloc/ProductsState.dart';
import 'package:hisab_kitab/feature/products/data/ProductsRepository.dart';

class ProductsBloc extends Bloc<ProductsEvent,ProductsState>{

  ProductsBloc():super(ProductsInitial()){
    var data;
    ProductsRepository productsRepository=ProductsRepository();
    on<GetProductsListEvent>((event, emit) async{
      try{
        emit(ProductsLoadingState());
        data=await productsRepository.getSubProducts(event.categoryId,event.subCategoryId);
        emit(ProductsLoadedState(data));
        if(data==null){
          emit(ProductsError("Error to load products"));
        }
      }
      finally{
        emit(ProductsLoadedState(data));
      }});
  }
}