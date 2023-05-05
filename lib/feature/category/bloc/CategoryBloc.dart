import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisab_kitab/feature/category/CategoryRepository.dart';

import '../../../networking/ApiProvider.dart';
import '../../../networking/EndPoint.dart';
import 'CategoryEvent.dart';
import 'CategoryState.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>
{

  CategoryBloc() : super(CategoryInitial()) {
    late var mList;
    final CategoryRepository categoryRepository=CategoryRepository();

    on<GetCategoryListEvent>((event, emit) async {
      try {
        emit(CategoryLoading());
         mList = await categoryRepository.fetchCategories();
        print("RESPONSEggggggggggg8888 ${mList.statusCode}");

        emit(CategoryLoaded(mList));
        if (mList== null) {
          emit(CategoryError(mList.message));
        }
      }finally {
        emit(CategoryLoaded(mList));
      }
    });
}
}