import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';

class PaginatorLoadResult<T> {
  PaginatorLoadResult({
    required this.entities,
    required this.currentPage,
    required this.totalPages,
  });

  final List<T> entities;
  final int currentPage;
  final int totalPages;
}

typedef EntityLoader<T> = Future<PaginatorLoadResult<T>> Function(int);

class Paginator<T> {
  Paginator(this.load);

  final List<T> _entities = <T>[];
  List<T> get entities => List<T>.unmodifiable(_entities);

  late int _currentPage;
  late int _totalPages;

  bool _isLoadingInProgress = false;

  final EntityLoader<T> load;

  Future<String?> loadMoviesNextPage() async {
    if (_currentPage >= _totalPages || _isLoadingInProgress) {
      return null;
    }
    _isLoadingInProgress = true;
    final int nextPage = _currentPage + 1;
    try {
      final PaginatorLoadResult<T> response = await load(nextPage);
      _currentPage = response.currentPage;
      _totalPages = response.totalPages;
      _entities.addAll(response.entities as Iterable<T>);
      return null;
    } on ApiClientException catch (error) {
      switch (error.type) {
        case ApiClientExceptionType.network:
          return 'No internet connection';
        default:
          return 'Something went wrong, try again later';
      }
    } catch (_) {
      return 'Unexpected error, try again later';
    } finally {
      _isLoadingInProgress = false;
    }
  }

  Future<String?> reset() async {
    _currentPage = 0;
    _totalPages = 1;
    _entities.clear();

    return loadMoviesNextPage();
  }
}
