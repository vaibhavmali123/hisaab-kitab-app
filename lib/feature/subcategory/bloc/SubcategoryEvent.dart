import 'package:equatable/equatable.dart';

class SubcategoryEvent extends Equatable
{

  final int categoryId;
  @override
  // TODO: implement props
  List<Object> get props => [];

  const SubcategoryEvent(this.categoryId);
}
class GetSubcategoryevent extends SubcategoryEvent{
  GetSubcategoryevent(super.categoryId);
}

abstract class ClickAction extends Equatable{
  final int categoryId;

  ClickAction(this.categoryId);
}