import 'package:assignment_test/views/itemsdetails/ItemDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment_test/bussinessLogic/cubit/items_state.dart';
import 'package:assignment_test/bussinessLogic/items_cubit.dart';
import 'package:assignment_test/dataModel/itemsModel.dart';
import 'package:assignment_test/repositery/items/itemsRepositery.dart';
import 'package:get/get.dart';

class ItemsTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsCubit, ItemsState>(
      builder: (context, state) {
        if (state is ItemsInitial) {
          return const Text('Press the button to load items.');
        } else if (state is ItemsLoading) {
          return const CircularProgressIndicator();
        } else if (state is ItemsLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.items.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return ListTile(
                        title: Text("${item.name}"),
                        subtitle: Text("${item.price}\$"),
                        onTap: () {
                        Get.toNamed("/itemsdetails", arguments:  item.id);
                        },
                      );
                    },
                  ),
                )
              else
                const Text('No items available.'),
              ElevatedButton(
                onPressed: () {
                  context.read<ItemsCubit>().loadItems();
                },
                child: const Text('Load items'),
              ),
            ],
          );
        } else if (state is ItemsError) {
          return const Text('Failed to load items.');
        } else {
          return const Text('Unknown state');
        }
      },
    );
  }
}
