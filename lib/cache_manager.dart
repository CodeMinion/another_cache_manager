
import 'dart:typed_data';

import 'package:another_cache_manager/another_cache.dart';
import 'package:another_cache_manager/caches/temp_file_cache.dart';

abstract class CacheManager extends Cache {
  void setCache(Cache cache);
}

class DefaultCacheManager implements CacheManager {

  Cache _cache;

  DefaultCacheManager({Cache cache = const TempFileCache()}):_cache = cache;

  @override
  Future<void> evict({required String key}) => _cache.evict(key: key);

  @override
  Future<Uint8List?> get({required String key})=> _cache.get(key: key);

  @override
  Future<void> put({required String key, required Uint8List bytes, Duration maxAge = const Duration(days: 30)})=> _cache.put(key: key, bytes: bytes, maxAge: maxAge);

  @override
  void setCache(Cache cache) {
    _cache = cache;
  }

}