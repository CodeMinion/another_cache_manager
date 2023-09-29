import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:another_cache_manager/another_cache.dart';
import 'package:another_cache_manager/cache_details.dart';

class MemoryCache implements Cache {

  final HashMap<String, CacheDetails> _internalCache;

  MemoryCache(): _internalCache = HashMap();

  @override
  Future<Uint8List?> get({required String key}) async {
    CacheDetails? details = _internalCache[key];

    if(details == null) {
      return null;
    }

    final timestamp = details.timestamp;
    final int maxAge = details.maxAge;

    final int currentTime = DateTime.now().millisecondsSinceEpoch;

    if(currentTime - timestamp <= maxAge) {
      return base64.decode(details.content!);
    }
    else {
      _internalCache.remove(key);
    }

    return null;
  }

  @override
  Future<void> put(
      {required String key,
      required Uint8List bytes,
      Duration maxAge = const Duration(days: 30)}) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    CacheDetails cacheDetails =
        CacheDetails(timestamp: timestamp, maxAge: maxAge.inMilliseconds, content: base64.encode(bytes));
    _internalCache.putIfAbsent(key, () => cacheDetails);
  }

  @override
  Future<void> evict({required String key}) async {
    _internalCache.remove(key);
  }
}
