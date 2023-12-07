import 'package:assignment_test/dataModel/itemsModel.dart';
import 'package:equatable/equatable.dart';


abstract class ItemDetailsState extends Equatable {
  const ItemDetailsState();

  @override
  List<Object?> get props => [];
}

class ItemDetailsInitial extends ItemDetailsState {}

class ItemDetailsLoading extends ItemDetailsState {}

class ItemDetailsLoaded extends ItemDetailsState {
  final ItemModel itemDetails;

  const ItemDetailsLoaded(this.itemDetails);

  @override
  List<Object?> get props => [itemDetails];
}

class ItemDetailsError extends ItemDetailsState {}
