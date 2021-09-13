import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_firebase_ddd/domain/auth/user.dart';
import 'package:notes_firebase_ddd/domain/core/value_objects.dart';

extension FirebaseUserDomainX on User {
  OwnUser toDomain() {
    return OwnUser(id: UniqueId.fromUniqueString(uid));
  }
}
