
import 'package:assignment_test/dataModel/itemsModel.dart';
import 'package:dio/dio.dart';

class ItemRepository {
  final Dio _dio = Dio();

  Future<List<ItemModel>> fetchItems() async {
    final url = 'https://6570f99009586eff6642273e.mockapi.io/items';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<ItemModel> items = data.map((item) => ItemModel.fromJson(item)).toList();
        return items;
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception('Failed to load items');
    }
  }
}
