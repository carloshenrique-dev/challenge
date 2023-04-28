import 'entities_model.dart';
import 'pagination_model.dart';

class Data {
  List<Entities>? entities;
  Pagination? pagination;

  Data({this.entities, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['entities'] != null) {
      entities = <Entities>[];
      json['entities'].forEach((v) {
        entities!.add(Entities.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (entities != null) {
      data['entities'] = entities!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}
