import 'package:caching_data/data/api/api_service.dart';
import 'package:caching_data/data/local/local_database.dart';
import 'package:caching_data/data/model/categories_model/catrgories_model.dart';
import 'package:caching_data/data/model/my_response/my_response.dart';
import 'package:caching_data/data/model/user/user_model.dart';

class UserRepo {
  final ApiService apiService;

  UserRepo({required this.apiService});

  Future<MyResponse> getAllCategories() => apiService.getAllCategories();

  Future<CategoryModel> inserCategoriesToDb(CategoryModel categoryModel) =>
      LocalDatabase.insertCategories(categoryModel: categoryModel);
  
  Future<List<CategoryModel>> getAllCachedCategories() => LocalDatabase.getCachedCategories();

  Future<int> deleteCachedCategories() => LocalDatabase.deleteAll();

}