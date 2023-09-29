# Another_Cache_Manager

Simple extensible cache manager for Flutter.

## Usage

```dart
final cacheManager = DefaultCacheManager(cache: MemoryCache());
await cacheManager.put(key: "test", bytes: Uint8List(0));
var cached = await cacheManager.get(key: "test");
```
