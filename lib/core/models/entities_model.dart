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
    return {
      'house_rules': {'name': name, 'active': active}
    };
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

  @override
  bool operator ==(covariant Entities other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.active == active &&
        other.order == order;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ active.hashCode ^ order.hashCode;
  }
}
