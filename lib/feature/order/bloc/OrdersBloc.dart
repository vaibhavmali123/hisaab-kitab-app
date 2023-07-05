import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisab_kitab/feature/order/bloc/OrderEvent.dart';
import 'package:hisab_kitab/feature/order/bloc/OrderState.dart';
import 'package:hisab_kitab/feature/order/data/OrdersRepository.dart';

class OrdersBloc extends Bloc<OrderEvent,OrderState>{

  OrdersBloc():super(InitialOrderState()){

    on<GetAllOrdersEvent>(getOrders);

  }

  FutureOr<void> getOrders(GetAllOrdersEvent event, Emitter<OrderState> emit) async{
  var data;
  OrdersRepository ordersRepository=OrdersRepository();
    try{
      emit(LoadingOrdersState());
     data=await ordersRepository.getAllOrders();
      print("Orders from bloc: $data");
      emit(LoadedOrdersState(data));
      print("FROM FINALLY: $data['statusCode']");

      if(data==null || data['statusCode']!=200){
        emit(ErrorOrderState("Error to load Orders"));
      }
    }
    finally{
      print("FROM FINALLY: $data");
      if(data==null || data['statusCode']!=200){
        emit(ErrorOrderState("Error to load Orders"));
      }
      else{
        emit(LoadedOrdersState(data));
      }
    }
  }
}