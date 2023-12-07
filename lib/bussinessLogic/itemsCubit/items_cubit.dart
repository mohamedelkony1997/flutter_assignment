
import 'package:assignment_test/bussinessLogic/itemsCubit/items_state.dart';
import 'package:assignment_test/repositery/items/itemsRepositery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final ItemRepository _repository;

  ItemsCubit(this._repository) : super(ItemsInitial());

  void loadItems() async {
    try {
      emit(ItemsLoading());
      final items = await _repository.fetchItems();
      emit(ItemsLoaded(items));
    } catch (e) {
      emit(ItemsError());
    }
  }
}
