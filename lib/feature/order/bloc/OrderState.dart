import 'package:equatable/equatable.dart';
import 'package:hisab_kitab/feature/order/model/OrdersModel.dart';

class OrderState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialOrderState extends OrderState{}

class LoadingOrdersState extends OrderState{}

class LoadedOrdersState extends OrderState{
  final OrdersModel ordersModel;
  LoadedOrdersState(this.ordersModel);
}
class ErrorOrderState extends OrderState{
  final message;
  ErrorOrderState(this.message);
}