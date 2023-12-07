import 'dart:convert';
import 'package:assignment_test/dataModel/itemsModel.dart';
import 'package:dio/dio.dart';

class ItemDetailsRepository {
  final Dio _dio = Dio();

  Future<ItemModel> fetchItemDetails(String itemId) async {
    final url = 'https://6570f99009586eff6642273e.mockapi.io/items/$itemId';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;
        return ItemModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load item details');
      }
    } catch (e) {
      throw Exception('Failed to load item details');
    }
  }
}
