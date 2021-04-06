import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:flutter/foundation.dart';

part 'set.g.dart';

@JsonSerializable()
class VCCSSet {
  final String name;
  final bool isMask;
  final String uid;

  VCCSSet._(this.name, this.isMask, this.uid);

  factory VCCSSet({@required String name, bool isMask = false, String uid}) {
    return VCCSSet._(name ?? "Unknown", isMask, uid ?? Uuid().v4());
  }

  VCCSSet copyWith({String name, bool isMask = false, String uid}) {
    return VCCSSet._(name ?? this.name, isMask ?? this.isMask, uid ?? this.uid);
  }

  Map<String, dynamic> toJson() => _$VCCSSetToJson(this);
  factory VCCSSet.fromJson(Map<String, dynamic> json) =>
      _$VCCSSetFromJson(json);
}
