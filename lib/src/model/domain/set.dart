import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

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
}
