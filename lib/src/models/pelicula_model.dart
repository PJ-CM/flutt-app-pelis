class Peliculas {
  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    popularity = json['popularity'] / 1; // pasando a double

    // voteCount = json['vote_count']; // sin pasar a int
    // voteCount = json['vote_count'].cast<int>(); // pasando a int
    // => NoSuchMethodError (NoSuchMethodError: Class 'int' has no instance method 'cast'.
    // voteCount = int.parse(json['vote_count']); // pasando a int
    // => _TypeError (type 'int' is not a subtype of type 'String')
    voteCount = json['vote_count'].toInt(); // pasando a int

    video = json['video'];
    posterPath = json['poster_path'];
    id = json['id'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];

    // genreIds = json['genre_ids'];
    // genreIds = json['genre_ids'].cast<List<int>>();

    var genreIdsFromJson = json['genre_ids'];
    List<int> genreIdsList = new List<int>.from(genreIdsFromJson);
    genreIds = genreIdsList;
    title = json['title'];
    voteAverage = json['vote_average'] / 1;
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  getPosterImg() {
    // return 'https://image.tmdb.org/t/p/w500/7D430eqZj8y3oVkLFfsWXGRcpEG.jpg';
    // return 'https://image.tmdb.org/t/p/w500/$posterPath';

    if (posterPath == null) {
      return 'https://ia-latam.com/wp-content/uploads/2018/12/No-image-found-1.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }
}

// enum OriginalLanguage { EN, KO, JA, IT }
