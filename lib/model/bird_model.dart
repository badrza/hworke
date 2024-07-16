import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hiveandcach/model/handle_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

@HiveType(typeId: 0)
class BirdModel extends ResultModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String family;
  @HiveField(2)
  final String image;

  BirdModel({
    required this.name,
    required this.family,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'family': family,
      'image': image,
    };
  }

  factory BirdModel.fromMap(Map<String, dynamic> map) {
    return BirdModel(
      name: map['name'] as String,
      family: map['family'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BirdModel.fromJson(String source) =>
      BirdModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
