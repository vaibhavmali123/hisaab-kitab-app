import 'package:equatable/equatable.dart';

//@immutable
abstract class CategoryEvent extends Equatable{

  const CategoryEvent();

  @override
  List<Object> get props => [];

}

class CategoryButtonClickedEvent extends CategoryEvent{

}
class GetCategoryListEvent extends CategoryEvent {}

abstract class CategoryAction extends Equatable{

 final int categoryId;

 CategoryAction(this.categoryId);
}
class CategorySelected extends CategoryAction{
  CategorySelected(super.categoryId);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}