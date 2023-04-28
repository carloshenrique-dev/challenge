// ignore_for_file: public_member_api_docs, sort_constructors_first
class Entities {
  int? id;
  String? name;
  int? active;
  int? order;

  Entities({this.id, this.name, this.active, this.order});

  Entities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['active'] = active;
    data['order'] = order;
    return data;
  }

  Entities copyWith({
    int? id,
    String? name,
    int? active,
    int? order,
  }) {
    return Entities(
      id: id ?? this.id,
      name: name ?? this.name,
      active: active ?? this.active,
      order: order ?? this.order,
    );
  }

  @override
  String toString() {
    return 'Entities(id: $id, name: $name, active: $active, order: $order)';
  }
}
