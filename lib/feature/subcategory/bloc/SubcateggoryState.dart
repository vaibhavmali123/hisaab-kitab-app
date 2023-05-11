import 'package:equatable/equatable.dart';

import '../model/SubcategoriesModel.dart';

class SubcateggoryState extends Equatable
{

  @override
  // TODO: implement props
  List<Object?> get props => [];

  const SubcateggoryState();
}

class SubcategoryInitial extends SubcateggoryState{

}

class SubcategoryLoading extends SubcateggoryState{

}
class SubcategoryLoaded extends SubcateggoryState{
  final SuubcategoriesModel suubcategoriesModel;

  const SubcategoryLoaded(this.suubcategoriesModel);
}

class SubcategoryError extends SubcateggoryState{
  final String? message;
  SubcategoryError(this.message);
}