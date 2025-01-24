class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final String? backdropUrl;
  final double rating;
  final String genre;
  final int year;
  final String type; // 'movie', 'series', or 'cartoon'

  const Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    this.backdropUrl,
    required this.rating,
    required this.genre,
    required this.year,
    required this.type,
  });

  // Sample data for testing
  static List<Movie> getSampleMovies() {
    return [
      Movie(
        id: '1',
        title: 'Inception',
        posterUrl:
            'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
        backdropUrl:
            'https://image.tmdb.org/t/p/original/s3TBrRGB1iav7gFOCNx3H31MoES.jpg',
        rating: 8.8,
        genre: 'Sci-Fi',
        year: 2010,
        type: 'movie',
      ),
      Movie(
        id: '2',
        title: 'The Dark Knight',
        posterUrl:
            'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
        backdropUrl:
            'https://image.tmdb.org/t/p/original/hkBaDkMWbLaf8B1lsWsKX7Ew3Xq.jpg',
        rating: 9.0,
        genre: 'Action',
        year: 2008,
        type: 'movie',
      ),
      Movie(
        id: '3',
        title: 'Breaking Bad',
        posterUrl:
            'https://image.tmdb.org/t/p/w500/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
        backdropUrl:
            'https://image.tmdb.org/t/p/original/tsRy63Mu5cu8etL1X7ZLyf7UP1M.jpg',
        rating: 9.5,
        genre: 'Drama',
        year: 2008,
        type: 'series',
      ),
      Movie(
        id: '4',
        title: 'Stranger Things',
        posterUrl:
            'https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg',
        backdropUrl:
            'https://image.tmdb.org/t/p/original/56v2KjBlU4XaOv9rVYEQypROD7P.jpg',
        rating: 8.7,
        genre: 'Sci-Fi',
        year: 2016,
        type: 'series',
      ),
      Movie(
        id: '5',
        title: 'Spider-Man: Into the Spider-Verse',
        posterUrl:
            'https://image.tmdb.org/t/p/w500/iiZZdoQBEYBv6id8su7ImL0oCbD.jpg',
        backdropUrl:
            'https://image.tmdb.org/t/p/original/7d6EY00g1c39SGZOoCJ5Py9nNth.jpg',
        rating: 8.4,
        genre: 'Animation',
        year: 2018,
        type: 'cartoon',
      ),
      Movie(
        id: '6',
        title: 'Toy Story 4',
        posterUrl:
            'https://image.tmdb.org/t/p/w500/w9kR8qbmQ01HwnvK4alvnQ2ca0L.jpg',
        backdropUrl:
            'https://image.tmdb.org/t/p/original/m67smI1IIMmYzCl9axvKNULVKLr.jpg',
        rating: 7.8,
        genre: 'Animation',
        year: 2019,
        type: 'cartoon',
      ),
    ];
  }

  static List<Movie> getByType(String type) {
    return getSampleMovies().where((movie) => movie.type == type).toList();
  }

  static List<Movie> getByGenre(String type, String genre) {
    return getByType(type).where((movie) => movie.genre == genre).toList();
  }
}
