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
