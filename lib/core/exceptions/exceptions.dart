// all exceptions including any exceptions from servers

class CacheException implements Exception {
  final String message;

  CacheException({this.message});
}
