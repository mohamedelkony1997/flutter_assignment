
import 'package:assignment_test/bussinessLogic/itemDetailsCubit/itemDetails_cubit.dart';
import 'package:assignment_test/bussinessLogic/itemDetailsCubit/itemDetails_state.dart';
import 'package:assignment_test/dataModel/itemsModel.dart';
import 'package:assignment_test/repositery/itemsdetails/ItemsdetailsRepositery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';



class ItemDetailsPage extends StatelessWidget {


  const ItemDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var id=Get.arguments;
    return BlocProvider(
      create: (context) => ItemDetailsCubit(ItemDetailsRepository()),
      child: ItemDetailsView(itemId:id ),
    );
  }
}

class ItemDetailsView extends StatelessWidget {
  final String itemId;

  const ItemDetailsView({Key? key, required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use BlocProvider.value to access an existing ItemDetailsCubit instance
    final cubit = BlocProvider.of<ItemDetailsCubit>(context);
    cubit.getItemDetails(itemId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: BlocBuilder<ItemDetailsCubit, ItemDetailsState>(
        builder: (context, state) {
          if (state is ItemDetailsLoading) {
            return const CircularProgressIndicator();
          } else if (state is ItemDetailsLoaded) {
            return _buildItemDetails(state.itemDetails);
          } else if (state is ItemDetailsError) {
            return const Text('Failed to load item details.');
          } else {
            return const Text('Unknown state');
          }
        },
      ),
    );
  }

  Widget _buildItemDetails(ItemModel itemDetails) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          itemDetails.image,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 16),
        Text('Item ID: ${itemDetails.id}'),
        Text('Name: ${itemDetails.name}'),
        Text('Price: ${itemDetails.price}\$'),
          Text('Type: ${itemDetails.type}'),
    
      ],
    );
  }
}
