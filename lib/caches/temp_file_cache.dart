
import 'dart:convert';
import 'dart:typed_data';

import 'package:another_cache_manager/another_cache.dart';
import 'package:another_cache_manager/cache_details.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

class TempFileCache implements Cache {

  const TempFileCache();

  @override
  Future<Uint8List?> get({required String key}) async {
    Directory tempDir = await getTemporaryDirectory();

    String tempPath = tempDir.path;
    String base64Key = base64.encode(utf8.encode(key));

    File cacheDetailsFile = File('$tempPath/$base64Key.json');
    File cacheContentFile = File('$tempPath/$base64Key.bin');

    if (!cacheDetailsFile.existsSync()) {
      // TODO Revisit this.
      return null;
    }

    CacheDetails cacheDetails = CacheDetails.fromJson(jsonDecode(
        await cacheDetailsFile.readAsString()));

    if (!cacheContentFile.existsSync()) {
      return null;
    }

    final timestamp = cacheDetails.timestamp;
    final int maxAge = cacheDetails.maxAge;

    final int currentTime = DateTime
        .now()
        .millisecondsSinceEpoch;

    if (currentTime - timestamp <= maxAge) {
        return cacheContentFile.readAsBytes();
    }
    else {
      await cacheContentFile.delete();
    }

    return null;
  }

  @override
  Future<void> put({required String key, required Uint8List bytes, Duration maxAge = const Duration(days: 30)}) async {
    Directory tempDir = await getTemporaryDirectory();

    String tempPath = tempDir.path;
    String base64Key = base64.encode(utf8.encode(key));

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    CacheDetails cacheDetails =
    CacheDetails(timestamp: timestamp, maxAge: maxAge.inMilliseconds);

    // Write cache details as a json file.
    File cacheDetailsFile = File('$tempPath/$base64Key.json');
    await cacheDetailsFile.writeAsString(jsonEncode(cacheDetails.toJson()));

    // Write content as a file.
    File cacheContentFile = File('$tempPath/$base64Key.bin');
    await cacheContentFile.writeAsBytes(bytes);

  }

  @override
  Future<void> evict({required String key}) async {
    Directory tempDir = await getTemporaryDirectory();

    String tempPath = tempDir.path;
    String base64Key = base64.encode(utf8.encode(key));

    File cacheDetailsFile = File('$tempPath/$base64Key.json');
    File cacheContentFile = File('$tempPath/$base64Key.bin');

    if(cacheDetailsFile.existsSync()) {
      cacheDetailsFile.deleteSync();
    }

    if(cacheContentFile.existsSync()) {
      cacheContentFile.deleteSync();
    }

  }


}