import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_tdd/core/errors/server_failure.dart';
import 'package:flutter_bloc_tdd/domain/entities/movie.dart';
import 'package:flutter_bloc_tdd/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository movieRepository;
  SearchMovies(this.movieRepository);

  Future<Either<Failure, List<Movie>>> call(String query) async {
    return await movieRepository.searchMovies(query);
  }
}
