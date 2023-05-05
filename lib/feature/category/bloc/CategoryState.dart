import 'package:equatable/equatable.dart';
import 'package:hisab_kitab/feature/category/model/CategoriesModel.dart';

class CategoryState extends Equatable{

  const CategoryState();

  @override
  List<Object?> get props => [];

}
class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final CategoriesModel categoriesModel;
  const CategoryLoaded(this.categoriesModel);
}
class CategoryError extends CategoryState {
  final String? message;
  const CategoryError(this.message);
}
