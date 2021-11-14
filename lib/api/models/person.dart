import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable(createToJson: false)
class Person {
  final String? id;
  final String? name;
  final String? lastName;
  final int? age;

  const Person(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.age});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
