import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes_firebase_ddd/domain/core/value_objects.dart';

part 'user.freezed.dart';

@freezed
abstract class OwnUser with _$OwnUser {
  const factory OwnUser({
    required UniqueId id,
  }) = _OwnUser;
}
