import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisab_kitab/feature/subcategory/SubCategoryRepository.dart';
import 'package:hisab_kitab/feature/subcategory/bloc/SubcategoryEvent.dart';
import 'package:hisab_kitab/feature/subcategory/bloc/SubcateggoryState.dart';
class SubcategoriesBloc extends Bloc<SubcategoryEvent,SubcateggoryState>{

  SubcategoriesBloc() : super(SubcategoryInitial()) {

    var  mlist;
    final SubCategoryRepository subCategoryRepository=SubCategoryRepository();

    on<GetSubcategoryevent>((event, emit) async{

      try{

        emit(SubcategoryLoading());
        mlist=await subCategoryRepository.getSubcategories(event.categoryId);
          print("RESS ${mlist.toString()}");
        emit(SubcategoryLoaded(mlist));
        if(mlist==null){
          emit(SubcategoryError("Error"));
        }
    }
      finally{
    emit(SubcategoryLoaded(mlist));
    }

    });
  }
}