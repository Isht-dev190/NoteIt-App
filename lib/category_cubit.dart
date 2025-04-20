import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<String> {
  CategoryCubit() : super('All'); // default category set to All

  void changeCategory(String newCategory) {
    emit(newCategory);
  }
}
