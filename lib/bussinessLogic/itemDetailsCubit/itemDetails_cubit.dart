
import 'package:assignment_test/bussinessLogic/itemDetailsCubit/itemDetails_state.dart';
import 'package:assignment_test/repositery/itemsdetails/ItemsdetailsRepositery.dart';
import 'package:bloc/bloc.dart';


class ItemDetailsCubit extends Cubit<ItemDetailsState> {
  final ItemDetailsRepository repository;

  ItemDetailsCubit(this.repository) : super(ItemDetailsInitial());

  Future<void> getItemDetails(String itemId) async {
    try {
      emit(ItemDetailsLoading());
      final itemDetails = await repository.fetchItemDetails(itemId);
      emit(ItemDetailsLoaded(itemDetails));
    } catch (e) {
      emit(ItemDetailsError());
    }
  }
}
