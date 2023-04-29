class Links {
  String? next;
  String? prev;

  Links({this.next, this.prev});

  Links.fromJson(Map<String, dynamic> json) {
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['next'] = next;
    data['prev'] = prev;
    return data;
  }

  @override
  bool operator ==(covariant Links other) {
    if (identical(this, other)) return true;

    return other.next == next && other.prev == prev;
  }

  @override
  int get hashCode => next.hashCode ^ prev.hashCode;
}
