
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_type.freezed.dart';

@freezed
class OrderType with _$OrderType {
  const factory OrderType.ascending() = Ascending;
  const factory OrderType.descending() = Descending;
}