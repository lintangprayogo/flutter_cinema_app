import 'package:freezed_annotation/freezed_annotation.dart';

part 'actor.freezed.dart';

@freezed
class Actor with _$Actor {
  const factory Actor({String? profilePath, required String name}) = _Actor;

  factory Actor.fromJSON(Map<String, dynamic> json) =>
      Actor(name: json['name'], profilePath: json['profile_path']);
}
