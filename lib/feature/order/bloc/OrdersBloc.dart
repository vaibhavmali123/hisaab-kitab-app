import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisab_kitab/feature/order/bloc/OrderEvent.dart';
import 'package:hisab_kitab/feature/order/bloc/OrderState.dart';
import 'package:hisab_kitab/feature/order/data/OrdersRepository.dart';

class OrdersBloc extends Bloc<OrderEvent,OrderState>{

  OrdersBloc():super(InitialOrderState()){

    on<GetAllOrdersEvent>(getCustomers);

  }

  FutureOr<void> getCustomers(GetAllOrdersEvent event, Emitter<OrderState> emit) async{
  var data;
  OrdersRepository ordersRepository=OrdersRepository();
    try{
      emit(LoadingOrdersState());
     data=await ordersRepository.getAllOrders();
      print("customers from bloc: $data");
      emit(LoadedOrdersState(data));
      if(data==null){
        emit(ErrorOrderState("Error to load products"));
      }
    }
    finally{
      emit(LoadedOrdersState(data));
    }

  }
}