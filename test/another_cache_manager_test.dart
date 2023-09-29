import 'dart:typed_data';

import 'package:another_cache_manager/caches/memory_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:another_cache_manager/another_cache_manager.dart';

void main() {
  test('adds one to input values', () async {

    WidgetsFlutterBinding.ensureInitialized();

    final cacheManager = DefaultCacheManager(cache: MemoryCache());
    await cacheManager.put(key: "test", bytes: Uint8List(0));
    var cached = await cacheManager.get(key: "test");

    expect(cached, isNotNull);

  });
}
