import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_tdd/domain/entities/movie.dart';
import 'package:flutter_bloc_tdd/domain/usecases/search_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_movie_repository.mocks.dart';

void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  const tQuery = 'Equalizer';

  final tMoviesList = [
    Movie(id: 1, title: 'Movie A', overview: 'Desc A', posterPath: '/imageA'),
    Movie(id: 2, title: 'Movie B', overview: 'Desc B', posterPath: '/imageB'),
  ];

  test('should get movies from the query from the repository', () async {
    //arrange
    when(mockMovieRepository.searchMovies(any)).thenAnswer(
      (_) async => Right(tMoviesList),
    );

    //act
    final result = await usecase(tQuery);

    expect(result, equals(Right(tMoviesList)));
    verify(mockMovieRepository.searchMovies(tQuery));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
