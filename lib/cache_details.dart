
import 'package:json_annotation/json_annotation.dart';
part 'cache_details.g.dart';

@JsonSerializable(includeIfNull: false)
class CacheDetails {

  int timestamp;
  int maxAge;
  String? content;
  CacheDetails({required this.timestamp, required this.maxAge, this.content});

  factory CacheDetails.fromJson(Map<String, dynamic> json) => _$CacheDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CacheDetailsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}