
import 'dart:typed_data';

abstract class Cache {

  ///
  /// Adds the specified data to the cache under the specified key.
  ///
  Future<void> put({required String key, required Uint8List bytes, Duration maxAge = const Duration(days: 30)});

  ///
  /// Retrieves the data cached under the spefied key if available, null otherwise.
  Future<Uint8List?> get({required String key});

  ///
  /// Removes the file from the cache.
  Future<void> evict({required String key});

}