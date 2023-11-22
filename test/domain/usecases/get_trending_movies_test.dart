import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_tdd/domain/entities/movie.dart';
import 'package:flutter_bloc_tdd/domain/usecases/get_trending_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_movie_repository.mocks.dart';

void main() {
  late GetTrendingMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTrendingMovies(mockMovieRepository);
  });

  final tMoviesList = [
    Movie(id: 1, title: 'Movie A', overview: 'Desc A', posterPath: '/imageA'),
    Movie(id: 2, title: 'Movie B', overview: 'Desc B', posterPath: '/imageB'),
  ];

  test('should get trending movies from the repository', () async {
    //arrange
    when(mockMovieRepository.getTrendingMovies()).thenAnswer(
      (_) async => Right(tMoviesList),
    );

    //act
    final result = await usecase();

    expect(result, Right(tMoviesList));
    verify(mockMovieRepository.getTrendingMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
