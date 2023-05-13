import 'package:equatable/equatable.dart';
import 'package:hisab_kitab/feature/products/model/ProductsModel.dart';
class ProductsEvent extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  const ProductsEvent();
}

class GetProductsListEvent extends ProductsEvent{
  final int categoryId;
  final int subCategoryId;
  GetProductsListEvent(this.categoryId, this.subCategoryId);
}

