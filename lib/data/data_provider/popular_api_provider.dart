import 'package:http/http.dart' as http;

class PopularAPIProvider {
  Future<String> getPopularMovies({required int page}) async {
    final Map<String, String> queryParameters = {
      'page': '$page',
    };
    try {
      final res = await http.get(
          Uri.parse('https://api.themoviedb.org/3/movie/popular')
              .replace(queryParameters: queryParameters),
          headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZjA0ZTMyMzEzMDhhZTdmZDMwZjFiNjYyZWRiZWE5MyIsInN1YiI6IjY1N2FiODczN2EzYzUyMDE0ZTZiNWMxZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.aonJEYutoa8P7Uwx6N0DS0TxBnRS6dVwq2qHbz5bTQ0'
          });

      if (res.statusCode != 200) {
        throw 'An error occurred';
      }

      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
