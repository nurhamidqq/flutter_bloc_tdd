import 'package:flutter_bloc_tdd/data/datasources/movie_remote_data_source.dart';
import 'package:flutter_bloc_tdd/data/datasources/remote/movie_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'mock_http_client.mocks.dart';

void main() {
  late MovieRemoteDataSource dataSource;
  late MockClient mockClient;

  const tQuery = "Equalizer";
  const tUrl = "https://api.themoviedb.org/3/trending/movie/day?language=en-US";
  const pUrl = 'https://api.themoviedb.org/3/movie/popular';
  const sUrl = 'https://api.themoviedb.org/3/search/movie?query=$tQuery';
  const tAuth =
      "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMzZjY2Y3Y2MxNTM3YjY0ODg1ZWQ4MjI0MDc2MmJjMSIsInN1YiI6IjY1MTE4NzFlMjZkYWMxMDBjYWJiMjA3MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-9gP_Glwvti7OiQukoh4K-USQtQaqjbhCDBjE-s0utA";
  const String sampleApiResponse = '''
{
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/path.jpg",
      "id": 1,
      "title": "Sample Movie",
      "original_language": "en",
      "original_title": "Sample Movie",
      "overview": "Overview here",
      "poster_path": "/path2.jpg",
      "media_type": "movie",
      "genre_ids": [1, 2, 3],
      "popularity": 100.0,
      "release_date": "2020-01-01",
      "video": false,
      "vote_average": 7.5,
      "vote_count": 100
    }
  ],
  "total_pages": 1,
  "total_results": 1
}
''';

  setUp(() {
    mockClient = MockClient();
    dataSource = MovieRemoteDataSourceImpl(mockClient);
  });

  test('should perfom a Get request on a url to get trending movies', () async {
    //arrange
    when(
      mockClient.get(Uri.parse(tUrl), headers: {'Authorization': tAuth}),
    ).thenAnswer((_) async => http.Response(sampleApiResponse, 200));

    //act
    await dataSource.getTrendingMovies();

    //assert
    verify(mockClient.get(Uri.parse(tUrl), headers: {'Authorization': tAuth}));
  });

  test('should perfom a Get request on a url to get popular movies', () async {
    //arrange
    when(
      mockClient.get(Uri.parse(pUrl), headers: {'Authorization': tAuth}),
    ).thenAnswer((_) async => http.Response(sampleApiResponse, 200));

    //act
    await dataSource.getPopularMovies();

    //assert
    verify(mockClient.get(Uri.parse(pUrl), headers: {'Authorization': tAuth}));
  });

  test('should perfom a GET request on a url to get search movies', () async {
    // arrange
    when(mockClient.get(Uri.parse(sUrl), headers: {'Authorization': tAuth}))
        .thenAnswer((_) async => http.Response(sampleApiResponse, 200));

    // act
    await dataSource.searchMovies(tQuery);

    // assert
    verify(mockClient.get(Uri.parse(sUrl), headers: {'Authorization': tAuth}));
  });
}
