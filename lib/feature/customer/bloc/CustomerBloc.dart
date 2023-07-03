import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisab_kitab/feature/customer/bloc/CustomerEvent.dart';
import 'package:hisab_kitab/feature/customer/bloc/CustomerState.dart';
import 'package:hisab_kitab/feature/customer/data/CustomerRepository.dart';
class CustomerBloc extends Bloc<CustomerEvent,CustomerState>{
  CustomerBloc():super(CustomerInitialState()){

    on<GetCustomerEvent>(getCustomers);
  }

  FutureOr<void> getCustomers(GetCustomerEvent event, Emitter<CustomerState> emit)async {
    var data;
      CustomerRepository customerRepository=CustomerRepository();
    try{
      emit(CustomerLoadingState());
      data=await customerRepository.getCustomers();
      print("customers from bloc: $data");
      emit(CustomerLoadedState(data));
      if(data==null){
        emit(CustomerErrorState("Error to load products"));
      }
    }
    finally{
      emit(CustomerLoadedState(data));
    }
  }
}