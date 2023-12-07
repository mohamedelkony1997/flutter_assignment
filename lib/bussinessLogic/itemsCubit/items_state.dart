import 'package:assignment_test/dataModel/itemsModel.dart';

abstract class ItemsState {}

class ItemsInitial extends ItemsState {}

class ItemsLoading extends ItemsState {}

class ItemsLoaded extends ItemsState {
  final List<ItemModel> items;

  ItemsLoaded(this.items);
}

class ItemsError extends ItemsState {}
