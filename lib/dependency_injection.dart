import 'package:flutter_bloc_tdd/data/datasources/movie_remote_data_source.dart';
import 'package:flutter_bloc_tdd/data/datasources/remote/movie_remote_data_source_impl.dart';
import 'package:flutter_bloc_tdd/data/repositories/movie_repository_impl.dart';
import 'package:flutter_bloc_tdd/domain/repositories/movie_repository.dart';
import 'package:flutter_bloc_tdd/domain/usecases/get_popular_movies.dart';
import 'package:flutter_bloc_tdd/domain/usecases/get_trending_movies.dart';
import 'package:flutter_bloc_tdd/domain/usecases/search_movies.dart';
import 'package:flutter_bloc_tdd/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:flutter_bloc_tdd/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:flutter_bloc_tdd/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;
void init() {
  //http client
  getIt.registerLazySingleton(() => http.Client());

  //data source
  getIt.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getIt()));

  //repository
  getIt.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getIt()));

  //usecase
  getIt.registerLazySingleton(() => GetPopularMovies(getIt()));
  getIt.registerLazySingleton(() => GetTrendingMovies(getIt()));
  getIt.registerLazySingleton(() => SearchMovies(getIt()));

  //bloc
  getIt.registerFactory(() => PopularMoviesBloc(getPopularMovies: getIt()));
  getIt.registerFactory(() => TrendingMoviesBloc(getTrendingMovies: getIt()));
  getIt.registerFactory(() => SearchMoviesBloc(searchMovies: getIt()));
}
