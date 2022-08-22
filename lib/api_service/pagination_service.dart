import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/paginationModel.dart';

class PaginationService {
  Future<List<PaginationModel>> get_pagination_service(page,limit) async {
         List<PaginationModel>? pagination_list =[];
    try {
      String url = 'https://picsum.photos/v2/list?page=$page&limit=$limit';
      http.Response response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
    
        var data = jsonDecode(response.body);
        for (var u in data) {
          PaginationModel paginationModel = PaginationModel(
              id: u['id'],
              author: u['author'],
              width: u['width'],
              height: u['height'],
              url: u['url'],
              downloadUrl: u["download_url"]);
          pagination_list.add(paginationModel);
        }
        return pagination_list;
      }
    } catch (e) {
      print('Erroe ${e.toString()}');
    }
    return pagination_list;
  }
}
