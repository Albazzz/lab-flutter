class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

final List<Movie> allMovies = [
  Movie(
    title: 'Invincible',
    year: 2021,
    genres: ['Animation', 'Action', 'Superhero'],
    posterUrl: 'https://image.tmdb.org/t/p/w500/yDWJYRAwMNKbIYT8ZB33qy84uzO.jpg',
    rating: 8.7,
  ),
  Movie(
    title: 'The Boys',
    year: 2019,
    genres: ['Action', 'Drama', 'Superhero'],
    posterUrl: 'https://image.tmdb.org/t/p/w500/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg',
    rating: 8.7,
  ),
  Movie(
    title: 'Doraemon',
    year: 1979,
    genres: ['Animation', 'Comedy', 'Family'],
    posterUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSS7_g_5lhYhXyrX2h3ecG9xvFinE2zDABAnA&s',
    rating: 8.4,
  ),
  Movie(
    title: 'Horimiya',
    year: 2021,
    genres: ['Anime', 'Romance', 'Comedy'],
    posterUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlpjE36ugqlT4_FMrHz2-rSEwGcdp2WS0XLA&s',
    rating: 8.1,
  ),
  Movie(
    title: 'Gen V',
    year: 2023,
    genres: ['Action', 'Drama', 'Superhero'],
    posterUrl: 'https://image.tmdb.org/t/p/original/uuot1N5AgZ7xRCKgm4ZCwOhgIJu.jpg',
    rating: 7.7,
  ),
];