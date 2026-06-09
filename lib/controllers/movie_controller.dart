import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieController extends ChangeNotifier {
  String _searchQuery = '';
  final Set<String> _selectedGenres = {};
  String _selectedSort = 'A-Z';

  String get searchQuery => _searchQuery;
  Set<String> get selectedGenres => _selectedGenres;
  String get selectedSort => _selectedSort;

  final List<String> availableGenres = [
    'Action',
    'Adventure',
    'Animation',
    'Anime',
    'Comedy',
    'Crime',
    'Drama',
    'Family',
    'Fantasy',
    'Horror',
    'Romance',
    'Superhero',
    'Supernatural',
    'Thriller',
  ];

  final List<String> sortOptions = ['A-Z', 'Z-A', 'Year', 'Rating'];

  void updateSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleGenre(String genre) {
    if (_selectedGenres.contains(genre)) {
      _selectedGenres.remove(genre);
    } else {
      _selectedGenres.add(genre);
    }
    notifyListeners();
  }

  void clearGenres() {
    _selectedGenres.clear();
    notifyListeners();
  }

  void updateSort(String sort) {
    _selectedSort = sort;
    notifyListeners();
  }

  List<Movie> getFilteredMovies() {
    var movies = allMovies.where((movie) {
      final matchesSearch = movie.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesGenre = _selectedGenres.isEmpty || 
          movie.genres.any((g) => _selectedGenres.contains(g));
      return matchesSearch && matchesGenre;
    }).toList();

    switch (_selectedSort) {
      case 'A-Z':
        movies.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Z-A':
        movies.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 'Year':
        movies.sort((a, b) => b.year.compareTo(a.year));
        break;
      case 'Rating':
        movies.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    return movies;
  }
}
