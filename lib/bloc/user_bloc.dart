import 'package:caching_data/bloc/user_event.dart';
import 'package:caching_data/bloc/user_state.dart';
import 'package:caching_data/data/model/categories_model/catrgories_model.dart';
import 'package:caching_data/data/model/my_response/my_response.dart';
import 'package:caching_data/data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
 final UserRepo userRepo;

 UserBloc(this.userRepo) : super(UsersInitial()) {
  on<GetUser>(_fetchUser);
 }

 _fetchUser(GetUser event, Emitter<UserState> emit) async {
   emit(UsersLoadInProgress());

    MyResponse myResponse = await userRepo.getAllCategories();
   
    if (myResponse.error.isEmpty) {
      List<CategoryModel> categories = myResponse.data as List<CategoryModel>;
      emit(UsersLoadInSuccess(categories: categories));
      await _updateCachedUser(categories);
    } else {
      print('ERROR USERS: ${myResponse.error}');
      List<CategoryModel> categories = await userRepo.getAllCachedCategories();
      if(categories.isNotEmpty) {
        emit(UsersFromCache(categories: categories));
      } else {
         emit(UsersLoadInFailure(errorText: myResponse.error));
      }

    }
 }

 _updateCachedUser(List<CategoryModel> users) async {
   int deletedCount = await userRepo.deleteCachedCategories();
   print("O'CHIRILGANLAR SONI:$deletedCount");
   for(var user in users) {
    await userRepo.inserCategoriesToDb(user);
   }
 }

}