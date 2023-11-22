import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_tdd/core/errors/server_exception.dart';
import 'package:flutter_bloc_tdd/core/errors/server_failure.dart';
import 'package:flutter_bloc_tdd/data/models/movie_model.dart';
import 'package:flutter_bloc_tdd/data/repositories/movie_repository_impl.dart';
import 'package:flutter_bloc_tdd/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../datasource/mock_movie_remote_data_source.mocks.dart';

void main() {
  late MovieRepositoryImpl movieRepositoryImpl;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    movieRepositoryImpl = MovieRepositoryImpl(mockMovieRemoteDataSource);
  });

  const tQuery = "Equalizer";

  final tMovieModelList = [
    MovieModel(
        id: 1, title: 'Movie A', overview: 'Desc A', posterPath: '/imageA'),
    MovieModel(
        id: 2, title: 'Movie B', overview: 'Desc B', posterPath: '/imageB'),
  ];

  test('should get trending movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.getTrendingMovies())
        .thenAnswer((_) async => tMovieModelList);
    final result = await movieRepositoryImpl.getTrendingMovies();
    verify(mockMovieRemoteDataSource.getTrendingMovies());
    expect(result, isA<Right<Failure, List<Movie>>>());
  });

  test('should get popular movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.getPopularMovies())
        .thenAnswer((_) async => tMovieModelList);

    final result = await movieRepositoryImpl.getPopularMovies();

    verify(mockMovieRemoteDataSource.getPopularMovies());
    expect(result, isA<Right<Failure, List<Movie>>>());
  });

  test('should search movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.searchMovies(tQuery))
        .thenAnswer((_) async => tMovieModelList);

    final result = await movieRepositoryImpl.searchMovies(tQuery);

    verify(mockMovieRemoteDataSource.searchMovies(tQuery));
    expect(result, isA<Right<Failure, List<Movie>>>());
  });

  test(
      'should return ServerFailure when the call to remote data source is unsuccessful',
      () async {
    when(mockMovieRemoteDataSource.getTrendingMovies())
        .thenThrow(ServerException());

    final result = await movieRepositoryImpl.getTrendingMovies();

    expect(result, isA<Left<ServerFailure, List<Movie>>>());
  });

  test(
      'should return ServerFailure when the call to remote data source is unsuccessful',
      () async {
    when(mockMovieRemoteDataSource.getPopularMovies())
        .thenThrow(ServerException());

    final result = await movieRepositoryImpl.getPopularMovies();

    expect(result, isA<Left<ServerFailure, List<Movie>>>());
  });

  test(
      'should return ServerFailure when the call to remote data source is unsuccessful',
      () async {
    when(mockMovieRemoteDataSource.searchMovies(tQuery))
        .thenThrow(ServerException());

    final result = await movieRepositoryImpl.searchMovies(tQuery);

    expect(result, isA<Left<ServerFailure, List<Movie>>>());
  });
}
