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
}
