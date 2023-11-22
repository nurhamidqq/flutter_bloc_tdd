import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tdd/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:flutter_bloc_tdd/presentation/pages/movie_list.dart';

class PopularMoviesPage extends StatelessWidget {
  const PopularMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
        builder: (context, state) {
          if (state is PopularMoviesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PopularMoviesError) {
            return Center(child: Text(state.message));
          } else if (state is PopularMoviesLoaded) {
            return MovieList(movies: state.movies);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
