import 'package:caching_data/data/model/categories_model/catrgories_model.dart';

abstract class UserState {}

class UsersInitial extends UserState {}

class UsersLoadInProgress extends UserState {}

class UsersLoadInSuccess extends UserState {
  UsersLoadInSuccess({required this.categories});

  final List<CategoryModel> categories;
}

class UsersLoadInFailure extends UserState {
  UsersLoadInFailure({required this.errorText});

  final String errorText;
}

class UsersFromCache extends UserState {
  final List<CategoryModel> categories;
  
  UsersFromCache({required this.categories});
}