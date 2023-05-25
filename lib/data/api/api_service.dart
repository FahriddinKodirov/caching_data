import 'package:caching_data/data/api/api_client.dart';
import 'package:caching_data/data/model/categories_model/catrgories_model.dart';
import 'package:caching_data/data/model/my_response/my_response.dart';
import 'package:dio/dio.dart';

class ApiService extends ApiClient {
  
 Future<MyResponse> getAllCategories() async {
    MyResponse myResponse = MyResponse(error: '');
    try {
      Response response =
          await dio.get('${dio.options.baseUrl}/categories');
      if (response.statusCode == 200) {
        myResponse.data = (response.data as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
      }
    } catch (err) {
      myResponse.error = err.toString();
    }
    return myResponse;
  }
  
}