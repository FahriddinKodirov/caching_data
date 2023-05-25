import 'package:cached_network_image/cached_network_image.dart';
import 'package:caching_data/bloc/user_bloc.dart';
import 'package:caching_data/bloc/user_event.dart';
import 'package:caching_data/bloc/user_state.dart';
import 'package:caching_data/data/api/api_service.dart';
import 'package:caching_data/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(UserRepo(apiService: ApiService()))..add(GetUser()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Cached'),
       
        ),
        body: BlocConsumer<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UsersLoadInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UsersLoadInFailure) {
                return Center(
                  child: Text(state.errorText),
                );
              } else if (state is UsersLoadInSuccess) {
                return ListView.builder(
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    var item = state.categories[index];
                    return ListTile(
                      title: Text(item.name,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),
                      subtitle: Text(item.createdAt,style: const TextStyle(fontSize: 12),),
                      trailing: CachedNetworkImage(
                        imageUrl: item.imageUrl,
                        placeholder: (context, url) {
                          return const CircularProgressIndicator();
                        },
                      ),
                    );
                  },
                );
              } else if (state is UsersFromCache) {
                return ListView.builder(
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    var item = state.categories[index];
                    return ListTile(
                      title: Text(item.name,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),
                      subtitle: Text(item.createdAt,style: const TextStyle(fontSize: 12),),
                      trailing: CachedNetworkImage(
                        imageUrl: item.imageUrl,
                        placeholder: (context, url) {
                          return const CircularProgressIndicator();
                        },
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
            listener: (context, state) {}),
      ),
    );
  }
}
