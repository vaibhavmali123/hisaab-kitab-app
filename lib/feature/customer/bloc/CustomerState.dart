import 'package:equatable/equatable.dart';
import 'package:hisab_kitab/feature/customer/model/CustomerModel.dart';
class CustomerState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
const CustomerState();
}

class CustomerInitialState extends CustomerState{

}
class CustomerLoadingState extends CustomerState{

}
class CustomerLoadedState extends CustomerState{
  final CustomerModel customerModel;
  CustomerLoadedState(this.customerModel);
}
class CustomerErrorState extends CustomerState{
  final message;

  CustomerErrorState(this.message);
}