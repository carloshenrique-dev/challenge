import 'links_model.dart';

class Pagination {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;
  Links? links;

  Pagination(
      {this.total,
      this.count,
      this.perPage,
      this.currentPage,
      this.totalPages,
      this.links});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['count'] = count;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['total_pages'] = totalPages;
    if (links != null) {
      data['links'] = links!.toJson();
    }
    return data;
  }

  @override
  bool operator ==(covariant Pagination other) {
    if (identical(this, other)) return true;

    return other.total == total &&
        other.count == count &&
        other.perPage == perPage &&
        other.currentPage == currentPage &&
        other.totalPages == totalPages &&
        other.links == links;
  }

  @override
  int get hashCode {
    return total.hashCode ^
        count.hashCode ^
        perPage.hashCode ^
        currentPage.hashCode ^
        totalPages.hashCode ^
        links.hashCode;
  }
}
